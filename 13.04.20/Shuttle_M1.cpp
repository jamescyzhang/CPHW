#include<iostream>
#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;

#define INF 1000000009
#define MAXN 1000
#define MAXM 10000

struct edge{
    int t,c,next;
}E[MAXM];
int V[MAXN],level[MAXN],q[MAXN],S,T,tot;

void read(int &x){
    char ch;
    for(ch=getchar();ch<'0'||ch>'9';ch=getchar());
    x=ch-'0';
    for(ch=getchar();ch>='0' && ch<='9';ch=getchar())x=x*10+ch-'0';
}

void addedge(int a,int b,int c){
    E[tot].t=b;E[tot].c=c;E[tot].next=V[a];V[a]=tot++;
    E[tot].t=a;E[tot].c=0;E[tot].next=V[b];V[b]=tot++;
}

bool BFS(){
    memset(level,0,sizeof(level));
    int head=0,tail=1;
    q[head]=S;
    level[S]=1;
    while(head<tail){
        int u=q[head++];
        if(u==T)return true;
        for(int p=V[u];p!=-1;p=E[p].next){
            int v=E[p].t;
            if(!level[v] && E[p].c){
                level[v]=level[u]+1;
                q[tail++]=v;
            }
        }
    }
    return false;
}

int DFS(int u,int lmt){
    if(u==T)return lmt;
    int ret=0,delta;
    for(int p=V[u];p!=-1;p=E[p].next){
        if(E[p].c && level[E[p].t]==level[u]+1){
            delta=DFS(E[p].t,min(lmt-ret,E[p].c));
            E[p].c-=delta;
            E[p^1].c+=delta;
            ret+=delta;
            if(lmt==ret)return ret;
        }
    }
    if(!ret)level[u]=-1;
    return ret;
}

int Dinic(){
    int maxflow=0;
    while(BFS())maxflow+=DFS(S,INF);
    return maxflow;
}

int setdinic(){
    memset(V,0xff,sizeof(V));
    memset(E,0,sizeof(E));
    tot=0;
}

int main()
{
    int m,n;
    scanf("%d%d",&m,&n);
    setdinic();
    int a;
    char c;
    S=0;T=m+n+1;
    int sum=0;
    for(int i=1;i<=m;i++){
        read(a);
        sum+=a;
        addedge(S,i,a);
        while(true){
            do c=getchar(); while (c==' '); ungetc(c,stdin);
            if (c==10 || c==13) break;
            scanf("%d",&a);
            addedge(i,m+a,INF);
        }
    }
    for(int i=1;i<=n;i++){
        scanf("%d",&a);
        addedge(m+i,T,a);
    }
    int mf=Dinic();
    for(int i=1;i<=m;i++)if(level[i])cout<<i<<" ";
    //for(int i=1;i<=
    cout<<endl;
    for(int i=m+1;i<=n+m;i++)if(level[i])cout<<i-m<<" ";
    cout<<endl;
    cout<<sum-mf<<endl;
    return 0;
}
