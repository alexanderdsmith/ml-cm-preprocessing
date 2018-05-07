while read line
do
  S1=`echo "$line" | tr "\t" "~" | cut -d "~" -f1`
  S2=`echo "$line" | tr "\t" "~" | cut -d "~" -f3`
  sentence=`echo "$line" | tr "\t" "~" | cut -d "~" -f2 | sed 's/"//g'`
  IFS=',' read -r -a array <<< "$sentence"
  for elm in "${array[@]}"
  do
    elmstripped=`echo "$elm" | sed 's/^ //g' | sed 's/ $//g'`
    printf "$1\t$S1 $elmstripped $S2\n"
  done
done
