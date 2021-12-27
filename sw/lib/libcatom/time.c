#include "time.h"

/**
 * @brief sleep for some specified duration
 * 
 * @param count time (in ms)
 */
void sleep(long unsigned int count)
{
    #ifdef SW_SLEEP
    count = count*DELAY_SCALE_FACTOR;
    while(count-->0);
    #endif
}

