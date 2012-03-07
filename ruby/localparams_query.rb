{
'q'=>'_query_:"{!dismax qf=$f1 mm=$mm1 pf=$f1 bq=$bq1 v=$q1}"',
'mm1'=>'0%',
'f1'=>'author^3 title^1',
'q1'=>'Dueber Constructivism',
'bq1'=>'_query_:"{!dismax qf=$f1 mm=\'100%\' v=$q1 }"^5',
'fl' => 'score,*'
}