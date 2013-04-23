#include<cstdio>
#include<sstream>
#include<iostream>
#include<queue>
#include<string>
#include<cstring>
using namespace std;
const int INF = 100000000;
int main()
{
    int cap[101][101];
    int flow[101][101];
    int n,m,f=0;
    scanf("%d%d",&m,&n);
    getchar();
    char temp[100];
    int cost,num,sum=0;
    int s=0,t=n+m+1;
    for(int i=1;i<=m;i++){
        cin.getline(temp,100);
        stringstream in(temp);//string流
        in>>cost;
        sum+=cost;
        cap[n+i][n+m+1]=cost;
        while(in>>num) cap[num][n+i]=INF;
    }
    for(int i=1;i<=n;i++){
        scanf("%d",&cost);
        cap[0][i]=cost;
    }
    //Edmonds-Karp算法求最大流
    queue<int> q;
    int a[101];
    int p[101];
    memset(a,0,sizeof(a));
    q.push(s);
    a[0]=INF;
    while(!q.empty()){
        int now=q.front();
        q.pop();
        for(int i=1;i<=t;i++) if(!a[i]&&cap[now][i]>flow[now][i]){
            q.push(i);
            p[i]=now;
            a[i]=min(a[now],cap[now][i]-flow[now][i]);
            if(i==t){
                for(int i=t;i!=s;i=p[i]){
                    flow[p[i]][i]+=a[t];
                    flow[i][p[i]]-=a[t];
                }
                f+=a[t];
                memset(a,0,sizeof(a));
                while(!q.empty()) q.pop();
                q.push(s);
                a[0]=INF;
                break;
            }
        }
		}
    for(int i=n+1;i<t;i++)
        if(!a[i]) printf("%d ",i-n);
    printf("\n");
    for(int i=1;i<=n;i++)
        if(!a[i]) printf("%d ",i);
    printf("\n");
    printf("%d\n",sum-f);
    return 0;
}
