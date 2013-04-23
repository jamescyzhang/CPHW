#include <cstdio>
#include <iostream>

int   grid[2000][30], rev[2000][30], low, high, n, b, cap[30], ans;


void datain () {
    int     i, j;
    scanf ("%d%d", &n, &b);
    for (i = 0; i < n; i++)
	for (j = 0; j < b; j++) {
	    scanf ( "%d", &grid[i][j]);
	    grid[i][j]--;
	    rev[i][grid[i][j]] = j;
	}
    for (i = 0; i < b; i++)
	scanf ("%d", &cap[i]);
}

int used[2000], to[2000], tot[30], found;
int path[2000], rec[2000];

void search (int pos, int len) {
    int     i, j, id;
    if (found)
	return;
    path[len] = pos;
    used[pos] = 1;
    for (i = low; i < high; i++)
	if (tot[grid[pos][i]] < cap[grid[pos][i]]) {
	    path[len + 1] = grid[pos][i];
	    rec[0] = len + 1;
	    for (j = 1; j <= rec[0]; j++)
		rec[j] = path[j];
	    found = 1;
	    return;
	}
    for (i = 0; i < n; i++)
	if ((!used[i]) && (to[i] != -1)) {
	    id = rev[pos][to[i]];
	    if ((id >= low) && (id < high)) {
		path[len + 1] = grid[pos][id];
		search (i, len + 2);
	    }
	}
}

int match () {
    int     i, j, count;
    for (i = 0; i < b; i++)
	tot[i] = 0;
    count = 0;
    for (i = 0; i < n; i++)
	to[i] = -1;
    for (i = 0; i < n; i++)
	for (j = low; (j < high) && (to[i] == -1); j++)
	    if (tot[grid[i][j]] < cap[grid[i][j]]) {
		tot[grid[i][j]]++;
		to[i] = grid[i][j];
		count++;
	    }
    while (count < n) {
	for (i = 0; i < n; i++)
	    used[i] = 0;
	found = 0;
	for (i = 0; i < n; i++)
	    if ((to[i] == -1) && (used[i] == 0) && (found == 0)) {
		search (i, 1);
		if (!found)
		    return (0);
	    }
	for (i = 1; i < rec[0]; i += 2)
	    to[rec[i]] = rec[i + 1];
	tot[rec[rec[0]]]++;
	count++;
    }
    return (1);
}

int ptry (int range) {
    int     i;
    for (i = 0; i + range <= b; i++) {
	low = i;
	high = i + range;
	if (match ())
	    return (1);
    }
    return (0);
}

void process () {
    int     delta;
    ans = b;
    delta = 16;
    while (delta > 0) {
	if ((ans - delta > 0) && (ptry (ans - delta)))
	    ans -= delta;
	delta = delta / 2;
    }
}

void dataout () {
    printf ("%d\n", ans);
}

main () {
    datain ();
    process ();
    dataout ();
}

