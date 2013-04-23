//1450 割点
#include<iostream>
#include<cstdio>
#include<cstring>
using  namespace std;
struct edge_node
{
    int p,next;
};
int dfn[30000],low[30000],t;
bool flag[30000];
edge_node edge[300000];
int cnt,m,n,x,y,head[30000];
void insert(int a,int b)
{
    ++cnt;
    edge[cnt].p=b;
    edge[cnt].next=head[a];
    head[a]=cnt;
}
void find(int father,int s)
{
    int count=0;
    dfn[s]=low[s]=++t;
    for (int k=head[s];k!=0;k=edge[k].next)
    {
        int v=edge[k].p;
        if (dfn[v]==0)
       {
            ++count;
            find(s,v);
            if (low[v]<low[s])
                low[s]=low[v];
            if (father!=0&&low[v]>=dfn[s])
            flag[s]=true;
        }
        else if (v!=father&&dfn[v]<low[s])
            low[s]=dfn[v];
        if (father==0&&count>1)
            flag[s]=true;
    }
}
int main()
{
    cin>>n;
    scanf("%d",&x);
    while (x!=0)
    {
        scanf("%d",&y);
        while (y!=0)
        {
            insert(x,y);
            insert(y,x);
            scanf("%d",&y);
        }
        scanf("%d",&x);
    }
    memset(flag,false,sizeof flag);
    find(0,1);
    for (int i=1;i<=n;++i)
        if (flag[i])
            printf("%d ",i);
    cout<<endl;
    return 0;
}
