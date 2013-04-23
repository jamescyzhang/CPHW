#include<iostream>
#include<cstdio>
#include<cstring>

using namespace std;

int f[20000][2];
int a[20000];
int n;

int min(int a,int b)
{
	return a<b?a:b;
}

int main()
{
	memset(f,0x3d,sizeof f);
	cin>>n;
	for (int i=1;i<=n;++i)
		scanf("%d",&a[i]);
	f[0][0]=0;
	f[0][1]=0;
	f[1][0]=a[1];
	f[1][1]=0;
	for (int i=2;i<=n;++i)
	{
		f[i][0]=min(f[i-1][1],f[i-1][0])+a[i];
		f[i][1]=min(f[i-1][0],f[i-2][0]);
	}
	cout<<min(f[n][0],f[n][1])<<endl;
	return 0;
}
