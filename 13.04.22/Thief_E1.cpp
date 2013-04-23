#include<cstdio>
#include<string>
#include<iostream>
#include<queue>
using namespace std;
const int dx[4]={0,1,0,-1};
const int dy[4]={1,0,-1,0};
struct ptype
{
       int x,y,dir;
};
int g[110][110];
bool been[110][110];
queue<ptype> q;
int r,c,k;
int main()
{
    //freopen("a.in","r",stdin);
    //freopen("a.out","w",stdout);
    scanf("%d%d",&r,&c);
    char ch;
    string get;
    int bx,by;
    for (int i=1;i<=r;i++)
    {
        cin >> get;
        for (int j=1;j<=c;j++)
        {
            char ch=get[j-1];
            if (ch=='*')
            bx=i,by=j;
            if (ch=='X') g[i][j]=1;
        }
    }
    for (int i=0;i<=c+1;i++)
    g[0][i]=g[r+1][i]=1;
    for (int i=0;i<=r+1;i++)
    g[i][0]=g[i][c+1]=1;
    scanf("%d",&k);
    string str;
    for (int t=1;t<=k;t++)
    {
    for (int i=1;i<=r;i++)
    for (int j=1;j<=c;j++)
    been[i][j]=0;
    cin >> str;
    int di;
    if (str[0]=='E') di=0;
    if (str[0]=='S') di=1;
    if (str[0]=='W') di=2;
    if (str[0]=='N') di=3;
    if (t==1)
    {
              q.push((ptype){bx+dx[di],by+dy[di],di});
              continue;
              }
    int len=q.size();
    for (int i=0;i<len;i++)
    {
    ptype p=q.front(); q.pop();
    int xx=p.x,yy=p.y;
    while (g[xx][yy]!=1  && !been[xx][yy])
    {
          been[xx][yy]=1;
          q.push((ptype){xx+dx[di],yy+dy[di],di});
          xx+=dx[p.dir]; yy+=dy[p.dir];
          }
          }
    }
    while (!q.empty())
    {
    ptype p=q.front(); q.pop();
    int xx=p.x,yy=p.y;
    while (g[xx][yy]!=1)
    {
          g[xx][yy]=2;
          xx+=dx[p.dir]; yy+=dy[p.dir];
          }
    }
    for (int i=1;i<=r;i++)
    {
        for (int j=1;j<=c;j++)
        {
            if (g[i][j]==1) printf("X");
            if (g[i][j]==2) printf("*");
            if (g[i][j]==0) printf(".");
            }
    printf("\n");
    }
    //fclose(stdin); fclose(stdout);
    return 0;
}
