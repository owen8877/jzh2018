# Two Popularity Ranking Algorithms

## How Hacker News ranking algorithm works

* https://medium.com/hacking-and-gonzo/how-hacker-news-ranking-algorithm-works-1d9b0cf2c08d

* Score function
  $$
  \mathrm{Score} = (P-1)/(T+2)^G
  $$
  $P$: Up votes - Down votes

  $T$: Time since submission

  $G$: Gravity parameter, defaults $1.8$.

## How Reddit ranking algorithms work

* https://medium.com/hacking-and-gonzo/how-reddit-ranking-algorithms-work-ef111e33d0d9

* Score function
  $$
  \begin{align*}
  t_s &= -t \\
  x & = U - D \\
  y & = \begin{cases}
  1, \quad \mathrm{if} \ x>0 \\
  0, \quad \mathrm{if} \ x = 0 \\
  -1, \quad \mathrm{if} \ x < 0
  \end{cases} \\
  z & = \begin{cases}
  |x|, \quad \mathrm{if} \ |x| \geq 1 \\
  1, \quad \mathrm{if} \ |x| < 1
  \end{cases}
  \end{align*}
  $$
  where $t$ is time since submission. $U$ is up vote and $V$ is down vote.
  $$
  \mathrm{Score} = \log_{10} z + \frac{yt_s}{45000}
  $$


