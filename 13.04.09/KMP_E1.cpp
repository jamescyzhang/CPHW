//1899 KMP 字符匹配

#include<iostream>
#include<cstdio>
#include<cmath>
#include<string>

using namespace std;

int pre[2000000];
char a[2000000], b[2000000];
string s, t;

int main()
{
    scanf("%s%s", a, b);
    s.assign(a);
    t.assign(b);
    pre[0] = -1;
    int j = -1;
    for (int i=1;i<t.size();++i)
    {
        while (j!=-1&&t[i]!=t[j+1]) j=pre[j];
        if (t[i]==t[j+1]) ++j;
        pre[i]=j;
    }

    j=-1;
    for (int i=0;i<s.size();++i)
    {
        while (j!=-1&&s[i]!=t[j+1]) j=pre[j];
        if (s[i]==t[j+1]) ++j;
        if (j==t.size()-1)
        {
            cout<<i-t.size()+2<<endl;
            return 0;
        }
    }
    cout<<"No find"<<endl;
    return 0;
}


