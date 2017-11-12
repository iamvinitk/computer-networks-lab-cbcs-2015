BEGIN{
#include<stdio.h>
count24=0;
count26 = 0;
}

{
if($1=="d" && $3 == 2 && $4 == 4)
count24++
if($1=="d" && $3 == 2 && $4 == 6)
count26++

}

END{
printf("no of pkts dropped from 2 to 4 ==> %d \n",count24)
printf("no of pkts dropped from 2 to 6 ==> %d \n",count26)
}
