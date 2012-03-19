[
  {
  'fl' => 'score, *',
  'defType' => 'dismax',
  'q' => 'the monkees',
  'qf' => 'title',
  'pf' => 'title'
  },
  {
  'fl' => 'score, *',
  'defType' => 'dismax',
  'q' => 'the monkees',
  'qf' => 'title',
  'pf' => 'title_exact^10 title'
  },
  {
  'fl' => 'score, *',
  'defType' => 'dismax',
  'q' => 'the monkees',
  'qf' => 'title',
  'pf' => 'title_exact^10 title_l^3 title'
  }

]