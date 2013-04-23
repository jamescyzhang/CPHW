//2050 细胞

#include <cstdio>
#include <memory.h>
#include <iostream>

using namespace std;

#define MD 1000000007

int n, i, p, j, aa, bb, cc, q;
int a[2000], dp[2000][2], ja[2][2], jb[2][2], jc[1001][10][2][2];
char k;

void prs(int a[2][2], int b[2][2], int c[2][2]) {
	int d[2][2], e[2][2];
	memcpy(d, b, sizeof(d));
	memcpy(e, c, sizeof(e));
	memset(a, 0, sizeof(d));
	for (int i=0; i<=1; i++) {
		for (int j=0; j<=1; j++) {
			for (int p=0; p<=1; p++) {
				a[i][j] = (a[i][j]+1LL*d[i][p]*e[p][j]%MD) % MD;
			}
		}
	}
}

int main() {
	scanf("%d", &n);
	for (i = 1; i <= n; i++) {
		for (k = getchar(); k<=32; k=getchar());
		a[i] = k-'0';
	}
	ja[0][0] = 0;
	ja[0][1] = 1;
	ja[1][0] = 1;
	ja[1][1] = 1;
	jc[0][0][0][0] = jc[0][0][1][1] = 1;
	for (i = 1; i <= 9; i++) {
		prs(jc[0][i], jc[0][i-1], ja);
	}
	for (i = 1; i <= n; i++) {
		for (j = 0; j <= 9; j++){
			memcpy(jc[i][j], jc[i-1][j], sizeof(ja));
			for (p=1; p<=9; p++)
				prs(jc[i][j], jc[i][j], jc[i-1][j]);
		}
	}

	dp[0][0] = 1;
	dp[0][1] = 0;

	for (i=1; i<=n; i++){
		memset(jb, 0, sizeof(jb));
		jb[0][0] = jb[1][1] = 1;
		for (j = 1; j <= a[i]; j++) {
			prs(jb, jb, ja);
		}
		for (j = i-1; j >= 0; j--) {
			aa = (1LL * dp[j][0] * jb[0][0] % MD + 1LL * dp[j][1] * jb[1][0] % MD) % MD;
			bb = (1LL * dp[j][0] * jb[0][1] % MD + 1LL * dp[j][1] * jb[1][1] % MD) % MD;
			dp[i][0] = (dp[i][0] + aa) % MD;
			dp[i][1] = (dp[i][1] + bb) % MD;
			prs(jb, jc[i-j][a[j]], jb);
		}
	}
	printf("%d\n", dp[n][0]);
}
