using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace API_SIGMA
{
    class FilterDate
    {
        DateTime dateTime;
        long milliseconds;

        public FilterDate(DateTime date)
        {
            this.dateTime = date;

            this.milliseconds = ConvertToMilliseconds(this.dateTime);
        }

        private long ConvertToMilliseconds(DateTime dateTime)
        {
            DateTimeOffset dateTimeOffset = new DateTimeOffset(dateTime);
            long milliseconds = dateTimeOffset.ToUnixTimeMilliseconds();
            return milliseconds;
        }

        public long getTime()
        {
            return this.milliseconds;
        }
    }
}
