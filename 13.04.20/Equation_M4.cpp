#include<iostream>
#include<cstdlib>
#include<cmath>
#include<vector>
#include<map>
#include<set>
#define max 4000037

using namespace std;

long answer[max],amount[max],use[max];
long mid;
long k[6],p[6];
long n,m,total;

long locate(long s)
{
  long h;
  h=s;
  while (h<0) h+=max;
  while (h>=max) h-=max;
  while (use[h] && answer[h]!=s)
  {
    h++;
    if (h>=max) h-=max;
  }
  return h;
}

void insert(long s)
{
  long posi=locate(s);
  if (!use[posi])
  {
    use[posi]=1;
    answer[posi]=s;
  }
  amount[posi]++;
}

void firsthalf(long d,long s)
{
  if (d==mid)
  {
    insert(s);
    return;
  }
  long t;
  for (long i=1; i<=m; i++)
  {
    t=k[d];
    if (t!=0 && i!=1)
      for (long j=0; j<p[d]; j++) t*=i;
    firsthalf(d+1,t+s);
  }
}
void dfs(long d,long s)
{
  if (d==n)
  {
    long posi;
    s=-s;
    posi=locate(s);
    if (answer[posi]==s) total+=amount[posi];
    return;
  }
  long t;
  for (long i=1; i<=m; i++)
  {
    t=k[d];
    if (t!=0 && i!=1)
      for (long j=0; j<p[d]; j++) t*=i;
    dfs(d+1,t+s);
  }
}

int main()
{
  cin>>n>>m;
  for (long i=0; i<n; i++) cin>>k[i]>>p[i];
  mid=n/2;
  firsthalf(0,0);
  dfs(mid,0);
  cout<<total<<endl;
  return 0;
}
