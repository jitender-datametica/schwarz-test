DELETE FROM DBP_DATA.tag_1;

INSERT INTO DBP_DATA.tag_1
(
 dat
,dat_vvj 
,kjmo
,kjmo_vj
,kjmo_vvj
,wtag_id
,kjwo
,kjwo_vj
,kjwo_vvj
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
,pjwo
,gjhj
,akt_gjhj
,akt_gjhj_komplett
,dat_vj_kt
)

SELECT
t0.dat
,t0.dat-728 AS dat_vvj
,t0.kjmo
,t0.kjmo_vj
,(extract(year from TO_DATE(CAST(t0.kjmo AS char(6)), 'YYYYMM')) - 2) * 100 + extract(month from TO_DATE(CAST(t0.kjmo AS char(6)), 'YYYYMM')) AS kjmo_vvj
,t0.wtag_id
,t0.kjwo
,t0.kjwo_vj
,(CAST(substring(t0.kjwo_vj, 1, 4) AS integer) - 1) * 100 + CAST(substring(t0.kjwo_vj, 5, 2) AS integer) AS kjwo_vvj
,t0.gjwo
,t0.gjwo_vj
,t0.wo_dat_von
,t0.wo_dat_bis
,t0.gjmo
,t0.gjmo_vj
,t0.kjqu
,t0.gjqu
,t0.kj
,t0.gj
,t0.kjtag_id
,t0.gjtag_id
,t0.kjwo_kl
,t0.kjwo_kl_dat_von
,t0.kjwo_kl_dat_bis
,t0.gjwo_kl
,t0.gjwo_kl_dat_von
,t0.gjwo_kl_dat_bis
,t0.dat_vj
,t0.akt_tag-t1.akt_tag akt_tag
,t0.akt_mo-t1.akt_mo akt_mo
,t0.akt_mo-t1.akt_mo_komplett akt_mo_komplett
,t0.akt_wo-t1.akt_wo akt_wo
,t0.akt_wo-t1.akt_wo_komplett akt_wo_komplett
,t0.akt_gjwo_kl-t1.akt_gjwo_kl akt_gjwo_kl
,t0.akt_gjwo_kl-t1.akt_gjwo_kl_komplett akt_gjwo_kl_komplett
,t0.akt_kjwo_kl-t1.akt_kjwo_kl akt_kjwo_kl
,t0.akt_kjwo_kl-t1.akt_kjwo_kl_komplett akt_kjwo_kl_komplett
,t0.akt_gjqu-t1.akt_gjqu akt_gjqu
,t0.akt_gjqu-t1.akt_gjqu_komplett akt_gjqu_komplett
,t0.akt_kjqu-t1.akt_kjqu akt_kjqu
,t0.akt_kjqu-t1.akt_kjqu_komplett akt_kjqu_komplett
,t0.akt_gj-t1.akt_gj akt_gj
,t0.akt_gj-t1.akt_gj_komplett akt_gj_komplett
,t0.akt_kj-t1.akt_kj akt_kj
,t0.akt_kj-t1.akt_kj_komplett akt_kj_komplett
,t0.mo_gj
,t0.mo_kj
,t0.pjwo
,t0.gjhj
,t0.akt_gjhj-t1.akt_gjhj akt_gjhj
,t0.akt_gjhj-t1.akt_gjhj_komplett akt_gjhj_komplett
,try_to_date(concat(year(t0.dat)-1, '-',  month(t0.dat) , '-', day(t0.dat))) dat_vj_kt
FROM DBP_ETL_PROCESS.tag_master_1 t0
INNER JOIN DBP_ETL_PROCESS.tag_master_1 t1_1
ON t0.dat<=t1.dat+3650
WHERE t1.dat= CURRENT_DATE -1
;

UPDATE dbp_data.tag_1 FROM (SELECT a.kjwo,
                                 CAST(FLOOR(a.kjwo/100)+1 AS CHAR(4))||'01' AS kjwo_neu
                          FROM (SELECT kjwo_vvj AS kjwo
                                FROM dbp_data.tag_1
                                WHERE dat >= '2000-01-01'
                                GROUP BY 1) a
                          LEFT JOIN dbp_data.tag_1 b
                            ON a.kjwo = b.kjwo
                          WHERE b.dat IS NULL
                          GROUP BY 1,2) b
                          
SET kjwo_vvj = b.kjwo_neu

WHERE dbp_data.tag.kjwo_vvj = b.kjwo
;

COMMIT;



