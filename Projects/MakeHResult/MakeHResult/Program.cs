using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MakeHResult
{
    class Program
    {
        static void Main(string[] args)
        {
            int result = MakeHResult(0, 32772, 12204);
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
    }
}
