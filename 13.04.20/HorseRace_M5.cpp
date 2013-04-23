#include<iostream>
#include<cstdio>
#include<algorithm>
using namespace std;
bool cmp(int a,int b){
    return a>b;
}
int a[2005],b[2005],n;
int main()
{
    scanf("%d",&n);
    for(int i=1;i<=n;i++)scanf("%d",&a[i]);
    for(int i=1;i<=n;i++)scanf("%d",&b[i]);
    sort(a+1,a+n+1,cmp);
    sort(b+1,b+n+1,cmp);
    int cnt=0;
    int a1,a2,b1,b2;
    a1=b1=1;
    a2=b2=n;
    while(a1<=a2){
        if(a[a1]>b[b1])cnt++,a1++,b1++;
        else if(a[a1]<b[b1])cnt--,b1++,a2--;
        else{
            if(a[a2]>b[b2])cnt++,a2--,b2--;
            else{
                if(a[a2]<b[b1])cnt--;
                a2--,b1++;
            }
        }
    }
    cout<<cnt*200<<endl;
    return 0;
}
