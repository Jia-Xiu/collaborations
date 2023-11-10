## Background

These scripts are used in the data analysis of "Changes in the bacterial rare biosphere after permanent application of composted tannery sludge in a tropical soil", https://doi.org/10.1016/j.chemosphere.2022.137487, following the original paper[^1]

Please contact me if you need any input or output data for these scripts.


## Main scripts
First, to clean up the OTU table (such as removing unwanted taxa and rarefy the table), I used the following script:
* [format_tables.Rmd](https://github.com/Jia-Xiu/collaborations/blob/main/Araujo_et_al_2022/format_tables.Rmd)

To define the rare biosphere, classify different types of rarity, I used this script:
* [Rare_biosphere_analysis_updates_16-11-2022.Rmd](https://github.com/Jia-Xiu/collaborations/blob/main/Araujo_et_al_2022/Rare_biosphere_analysis_updates_16-11-2022.Rmd)

You can also apply this script to take a look of different rarity cutoffs:
* [find_the_rare_biosphere_cutoffs.Rmd](https://github.com/Jia-Xiu/collaborations/blob/main/Araujo_et_al_2022/find_the_rare_biosphere_cutoffs.Rmd)

If you want to run community assembly analysis, please check the following scripts:
* [nti_analysis_CTS_dataset_rare.R](https://github.com/Jia-Xiu/collaborations/blob/main/Araujo_et_al_2022/nti_analysis_CTS_dataset_rare.R)
* [RC_bray_analysis_CTS_dataset_rare.R](https://github.com/Jia-Xiu/collaborations/blob/main/Araujo_et_al_2022/RC_bray_analysis_CTS_dataset_rare.R)
* [Assembly_processes_rare_dominant_biospheres.Rmd](https://github.com/Jia-Xiu/collaborations/blob/main/Araujo_et_al_2022/Assembly_processes_rare_dominant_biospheres.Rmd)

## The source scripts
* [TruncateTable.R](https://github.com/Jia-Xiu/collaborations/blob/main/Araujo_et_al_2022/TruncateTable.R)

* [rad.matrix.R](https://github.com/Jia-Xiu/collaborations/blob/main/Araujo_et_al_2022/rad.matrix.R)

* [SummarizeRarityTypes.R](https://github.com/Jia-Xiu/collaborations/blob/main/Araujo_et_al_2022/SummarizeRarityTypes.R)


[^1]: [Jia, X., Dini-Andreote, F. & Salles, J.F. Unravelling the interplay of ecological processes structuring the bacterial rare biosphere. ISME COMMUN. 2, 96 (2022).](https://www.nature.com/articles/s43705-022-00177-6)

