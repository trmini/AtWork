using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;

using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace MakeHResult
{
    class Program
    {
        static void Main(string[] args)
        {
            int result = MakeHResult("SEVERITY_ERROR", "FACILITY_ITF", "12204");

            if (args.Length != 2)
            {
                return;
            }

            string inputFile = args[0];
            string outputFile = args[1];

            if (!File.Exists(inputFile))
            {
                System.Diagnostics.Debug.Assert(false, inputFile + " doesn't exist.");
                return;
            }

            using (TextReader tr = new StreamReader(inputFile))
            {
                TextWriter tw = new StreamWriter(outputFile, true /*append*/);
                do
                {
                    string line = tr.ReadLine();
                    Regex regEx = new Regex("#define (?<ErrorName>\\w+) MAKE_HRESULT\\((?<Severity>SEVERITY_\\w+), (?<Facility>FACILITY_\\w+), (?<ErrorCode>\\d+)\\)");
                    Match match = regEx.Match(line);
                    if (match.Success)
                    {
                        tw.WriteLine(match.Groups["ErrorName"].Value + ", " + MakeHResult(match.Groups["Severity"].Value, match.Groups["Facility"].Value, match.Groups["ErrorCode"].Value));
                    }
                }
                while (tr.Peek() != -1);

                tr.Close();

                tw.Flush();
                tw.Close();
            }

        }

        static int MakeHResult(string severity, string facility, string code)
        {
            return MakeHResult(GetSeverity(severity), GetFacility(facility), GetCode(code));
        }

        //  HRESULTs are 32 bit values layed out as follows
        //  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
        //  +-+-+-+-+-+---------------------+-------------------------------+
        //  |S|R|C|N|r|    Facility         |               Code            |
        //  +-+-+-+-+-+---------------------+-------------------------------+
        //
        //  where
        //
        //      S - Severity - indicates success/fail
        //
        //          0 - Success
        //          1 - Fail (COERROR)
        //
        //      R - reserved portion of the facility code, corresponds to NT's
        //              second severity bit.
        //
        //      C - reserved portion of the facility code, corresponds to NT's
        //              C field.
        //
        //      N - reserved portion of the facility code. Used to indicate a
        //              mapped NT status value.
        //
        //      r - reserved portion of the facility code. Reserved for internal
        //              use. Used to indicate HRESULT values that are not status
        //              values, but are instead message ids for display strings.
        //
        //      Facility - is the facility code
        //
        //      Code - is the facility's status code
        //
        static int MakeHResult(ulong severity, ulong facility, ulong code)
        {
            return (int) (severity << 31 | facility << 16 | code);
        }

        static ulong GetSeverity(string severity)
        {
            switch(severity.ToUpper())
            {
                case "SEVERITY_ERROR":
                    return 1;
                case "SEVERITY_SUCCESS":
                default:
                    return 0;
            }
        }

        static ulong GetFacility(string facility)
        {
            switch(facility.ToUpper())
            {
                case "FACILITY_ITF":
                    return 0x4;

                case "FACILITY_NULL":
                default:
                    return 0x0;
            }
        }

        static ulong GetCode(string code)
        {
            try
            {
                return ulong.Parse(code);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.Assert(false, ex.Message + " Invalid code: " + code);
            }
            return 0;
        }
    }
}
