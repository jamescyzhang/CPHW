#include<iostream>
#include<cstdio>
#include<cstring>
#include<algorithm>
#include<cstdlib>
#define INF 1061109567
using namespace std;
int t[50],a[50][50],h[50];
int n,m,k;
int okok[50][50];
int ok(){
    memset(okok,63,sizeof(okok));
    for (int i=1;i<=m;i++)
        for (int j=0;j<t[i];j++)
            for (int k=j+1;k<t[i];k++)
                okok[a[i][j]][a[i][k]]=okok[a[i][k]][a[i][j]]=1;
    for (int k=1;k<=n+2;k++)
        for (int i=1;i<=n+2;i++)
            for (int j=1;j<=n+2;j++)
                okok[i][j]=min(okok[i][j],okok[i][k]+okok[k][j]);
    return okok[n+1][n+2]<INF;
}
int V,S,T;
struct ed{
       int v,f;
       int next,op;
}e[100000];int tot=0;
int g[10000];
int flow=0;
void ae(int u,int v,int f){
     tot++;
     e[tot].v=v;e[tot].f=f;e[tot].next=g[u];e[tot].op=tot+1;g[u]=tot;
     tot++;
     e[tot].v=u;e[tot].f=0;e[tot].next=g[v];e[tot].op=tot-1;g[v]=tot;
}
int d[10000];
int vis[10000];

int qu[10000];int p,q;
int label(){
    p=q=0;
    memset(d,63,sizeof(d));
    qu[q++]=S;
    d[S]=0;
    while(p!=q){
                int u=qu[p++];
                for (int i=g[u];i;i=e[i].next){
                    int v=e[i].v;
                    if(d[v]==INF && e[i].f>0){//
                                  d[v]=d[u]+1;
                                  if(v==T)return 1;
                                  qu[q++]=v;
                    }
                }
    }
    return 0;
}
int aug(int u,int mi=INF){
    if(u==T)return flow+=mi,mi;
    int sum=0;
    vis[u]=1;
    for (int i=g[u];i;i=e[i].next){
        int v=e[i].v;
        if (e[i].f>0 && !vis[v] && d[v]==d[u]+1){
                    int delta=aug(v,min(mi,e[i].f));
                    e[i].f-=delta;
                    e[e[i].op].f+=delta;
                    sum+=delta;
                    mi-=delta;
                    if(mi==0)break;
        }
    }
    return sum;
}
void dinic(){
     while(label()){
                  memset(vis,0,sizeof(vis));
                  while(aug(S));
     }
}
int main()
{
    scanf("%d%d%d",&n,&m,&k);
    for (int i=1;i<=m;i++){
        scanf("%d%d",&h[i],&t[i]);
        for (int j=0;j<t[i];j++){
            scanf("%d",&a[i][j]);
            if(a[i][j]==0)a[i][j]=n+1;
            if(a[i][j]==-1)a[i][j]=n+2;
        }
    }
    if(!ok()){
              printf("0\n");
              return 0;
    }
    S=0;
    T=n+1;
    for (int ans=1;;ans++){
        for (int i=1;i<=m;i++){
            int u=a[i][(ans-1)%t[i]];
            int v=a[i][ans%t[i]];
            if (u==n+2)continue;
            if (v==n+2){
                        ae(S,u+(ans-1)*(n+1),h[i]);

            }
            else
                        ae(v+ans*(n+1),u+(ans-1)*(n+1),h[i]);
        }
        for (int i=1;i<=n+1;i++)
            ae(i+ans*(n+1),i+(ans-1)*(n+1),INF);
        dinic();
        if(flow>=k){
                    printf("%d\n",ans);
                    return 0;
        }
    }
}

