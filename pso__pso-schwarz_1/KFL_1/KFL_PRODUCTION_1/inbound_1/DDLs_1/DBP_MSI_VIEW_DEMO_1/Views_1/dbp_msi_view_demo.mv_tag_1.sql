CREATE OR REPLACE VIEW dbp_msi_view_demo.mv_tag_1
AS
SELECT
dat,
wtag_id,
kjtag_id,
gjtag_id,
dat_vj,
dat_vj - 364 AS dat_vvj,
kjwo,
wo_dat_von,
wo_dat_bis,
kjmo,
kjmo_vj,
kj,
mo_gj,
mo_kj,
gjmo,
gjmo_vj,
gjqu,
gj,
akt_tag,
akt_wo * 10000 + akt_tag AS akt,
akt_wo_komplett * 10000 + akt_tag AS akt_komplett,
akt_wo,
akt_wo_komplett,
akt_mo,
akt_mo_komplett,
akt_gj,
akt_gj_komplett,
akt_kj,
akt_kj_komplett,
akt_gjqu,
akt_gjqu_komplett,
MOD(kjwo, 100) || ' (' ||wo_dat_von || '-' ||wo_dat_bis || ')' AS wo_von_bis,
TO_DATE(SUBSTRING(CAST(dat AS DATE) , 1, 8) ||'01', 'YYYY-MM_1-DD')  AS kjmo_dat,
akt_mo / 3 AS akt_qu,
CASE
--WHEN CAST(((kj-1900)*10000+301) AS DATE) BETWEEN wo_dat_von AND wo_dat_bis THEN kj*100+1
when to_date(to_char(KJ) || '-03-01','YYYY-MM_1-DD') BETWEEN WO_DAT_VON AND WO_DAT_BIS THEN KJ*100+1


ELSE gjwo_kl END AS gjwo_neu,
kjwo_kl,
EXTRACT (DAY FROM dat)  AS tag_tag,
EXTRACT (DAY FROM CURRENT_DATE - 1 ) AS referenz_tag
FROM dbp_view.v_tag_1  v01
WHERE v01.akt_gj BETWEEN -11 AND 1;