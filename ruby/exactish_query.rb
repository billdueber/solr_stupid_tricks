[
  {
  'fl' => 'score, *',
  'defType' => 'dismax',
  'q' => 'the monkees',
  'qf' => 'title',
  'pf' => 'title^2'
  },
  {
  'fl' => 'score, *',
  'defType' => 'dismax',
  'q' => 'the monkees',
  'qf' => 'title',
  'pf' => 'title_exact^10 title^2'
  },
  {
  'fl' => 'score, *',
  'defType' => 'dismax',
  'q' => 'the monkees',
  'qf' => 'title',
  'pf' => 'title_exact^10 title_l^3 title^2'
  }

]