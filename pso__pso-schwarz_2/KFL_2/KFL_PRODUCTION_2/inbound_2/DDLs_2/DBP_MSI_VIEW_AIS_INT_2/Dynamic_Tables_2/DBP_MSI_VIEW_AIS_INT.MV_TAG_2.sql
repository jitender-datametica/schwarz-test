CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_TAG_2
(
dat
,kjmo
,kjmo_vj
,wtag_id
,kjwo
,kjwo_vj
,gjwo
,gjwo_vj
,wo_dat_von
,wo_dat_bis
,gjmo
,gjmo_vj
,kjqu
,gjqu
,kj
,gj
,kjtag_id
,gjtag_id
,kjwo_kl
,kjwo_kl_dat_von
,kjwo_kl_dat_bis
,gjwo_kl
,gjwo_kl_dat_von
,gjwo_kl_dat_bis
,dat_vj
,akt_tag
,akt_mo
,akt_mo_komplett
,akt_wo
,akt_wo_komplett
,akt_gjwo_kl
,akt_gjwo_kl_komplett
,akt_kjwo_kl
,akt_kjwo_kl_komplett
,akt_gjqu
,akt_gjqu_komplett
,akt_kjqu
,akt_kjqu_komplett
,akt_gj
,akt_gj_komplett
,akt_kj
,akt_kj_komplett
,mo_gj
,mo_kj
,dat_vvj
,akt_qu
,dat_vm
,jahrwoche
,dat_vj_date
,dat_vj_kt
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
     v01.dat
   , v01.kjmo
   , v01.kjmo_vj
   , v01.wtag_id
   , v01.kjwo
   , v01.kjwo_vj
   , v01.gjwo
   , v01.gjwo_vj
   , v01.wo_dat_von
   , v01.wo_dat_bis
   , v01.gjmo
   , v01.gjmo_vj
   , v01.kjqu
   , v01.gjqu
   , v01.kj
   , v01.gj
   , v01.kjtag_id
   , v01.gjtag_id
   , v01.kjwo_kl
   , v01.kjwo_kl_dat_von
   , v01.kjwo_kl_dat_bis
   , v01.gjwo_kl
   , v01.gjwo_kl_dat_von
   , v01.gjwo_kl_dat_bis
   , v01.dat_vj
   , v01.akt_tag
   , v01.akt_mo
   , v01.akt_mo_komplett
   , v01.akt_wo
   , v01.akt_wo_komplett
   , v01.akt_gjwo_kl
   , v01.akt_gjwo_kl_komplett
   , v01.akt_kjwo_kl
   , v01.akt_kjwo_kl_komplett
   , v01.akt_gjqu
   , v01.akt_gjqu_komplett
   , v01.akt_kjqu
   , v01.akt_kjqu_komplett
   , v01.akt_gj
   , v01.akt_gj_komplett
   , v01.akt_kj
   , v01.akt_kj_komplett
   , v01.mo_gj
   , v01.mo_kj
   , v01.dat_vj-364
   , v01.akt_mo/3
   , ADD_MONTHS(v01.dat,-1)
   , CASE  WHEN v01.kjwo / 100 <> v01.kj 
           THEN CASE WHEN MOD( v01.kjwo, 100) IN (52,53) 
           THEN v01.kj *100
           ELSE (v01.kj *100) + 53 
           END ELSE v01.kjwo
           END AS jahrwoche
   , ADD_MONTHS(dat,-12) AS dat_vj_date
 --AP0168833/SPEC0213188 sschuecke 25.08.2023 / Erweiterung um Spalte DAT_VJ_KT für Schaltjahre
   ,v01.dat_vj_kt
   FROM dbp_view.v_tag_2 v01;