#include<iostream>
#include<cstdio>
#include<algorithm>
using namespace std;
struct node
{
    long long val;
    int time,next;
};
int n,cnt;
node hash[200007];
int head[200007];
int h(long long x)
{
    return x%100007;
}
int find(long long x)
{
    int now=h(x);
    for (int k=head[now];k!=0;k=hash[k].next)
        if (hash[k].val==x) return k;
    return 0;
}
void insert(long long x)
{
    int ok=find(x);
    if (ok)
    {
        ++hash[ok].time;
        return;
    }
    int now=h(x);
    ++cnt;
    hash[cnt].val=x;
    hash[cnt].time=1;
    hash[cnt].next=head[now];
    head[now]=cnt;
}
bool cmp(node x,node y)
{
    return x.val<y.val;
}
int main()
{
    scanf("%d",&n);
    long long x;
    for (int i=1;i<=n;++i)
    {
        scanf("%lld",&x);
        insert(x);
    }
    sort(hash+1,hash+cnt+1,cmp);
    for (int i=1;i<=cnt;++i)
    {
        printf("%lld %d\n",hash[i].val,hash[i].time);
    }
    return 0;
}
