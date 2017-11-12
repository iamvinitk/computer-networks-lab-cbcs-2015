BEGIN{
#include<stdio.h>
count = 0
}

{
if($1 == d){
count++
}
END{
printf("No. of packets dropped %d", count)
}
