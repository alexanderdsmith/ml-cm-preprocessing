all: finalreport.tsv

struct1.txt: Rubric.txt
	cat Rubric.txt | tr "\t" "~" | cut -d "~" -f1 > $@

struct2.txt: Rubric.txt
	cat Rubric.txt | tr "\t" "~" | cut -d "~" -f2 > $@

score1.txt: Rubric.txt
	cat Rubric.txt | tr "\t" "~" | cut -d "~" -f3 > $@

score2.txt: Rubric.txt
	cat Rubric.txt | tr "\t" "~" | cut -d "~" -f4 > $@

score3.txt: Rubric.txt
	cat Rubric.txt | tr "\t" "~" | cut -d "~" -f5 > $@

score1.tsv: struct1.txt struct2.txt score1.txt
	paste struct1.txt score1.txt struct2.txt | egrep -v '\t\t' > $@

score2.tsv: struct1.txt struct2.txt score2.txt
	paste struct1.txt score2.txt struct2.txt | egrep -v '\t\t' > $@

score3.tsv: struct1.txt struct2.txt score3.txt
	cat score3.txt | tr '\r' ' ' > temp.txt
	cat temp.txt > score3.txt
	paste struct1.txt score3.txt struct2.txt | egrep -v '\t\t' > $@

final1.tsv: score1.tsv scoreformat.sh
	cat score1.tsv | bash scoreformat.sh 1 > $@

final2.tsv: score2.tsv scoreformat.sh
	cat score2.tsv | bash scoreformat.sh 2 > $@

final3.tsv: score3.tsv scoreformat.sh
	cat score3.tsv | bash scoreformat.sh 3 > $@

finalreport.tsv: final1.tsv final2.tsv final3.tsv
	cat final1.tsv > $@
	cat final2.tsv >> $@
	cat final3.tsv >> $@

clean:
	rm -f final1.tsv final2.tsv final3.tsv score1.tsv score2.tsv score3.tsv struct1.txt struct2.txt score1.txt score2.txt score3.txt temp.txt
