create or replace view KFL_PRODUCTION.DBP_MSI_VIEW2.MV_TAG_1(
	DAT,
	KJMO,
	KJMO_VJ,
	WTAG_ID,
	KJWO,
	KJWO_VJ,
	GJWO,
	GJWO_VJ,
	WO_DAT_VON,
	WO_DAT_BIS,
	GJMO,
	GJMO_VJ,
	KJQU,
	GJQU,
	KJ,
	GJ,
	KJTAG_ID,
	GJTAG_ID,
	KJWO_KL,
	KJWO_KL_DAT_VON,
	KJWO_KL_DAT_BIS,
	GJWO_KL,
	GJWO_KL_DAT_VON,
	GJWO_KL_DAT_BIS,
	DAT_VJ,
	AKT_TAG,
	AKT_MO,
	AKT_MO_KOMPLETT,
	AKT_WO,
	AKT_WO_KOMPLETT,
	AKT_GJWO_KL,
	AKT_GJWO_KL_KOMPLETT,
	AKT_KJWO_KL,
	AKT_KJWO_KL_KOMPLETT,
	AKT_GJQU,
	AKT_GJQU_KOMPLETT,
	AKT_KJQU,
	AKT_KJQU_KOMPLETT,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	AKT_KJ,
	AKT_KJ_KOMPLETT,
	MO_GJ,
	MO_KJ,
	DAT_VVJ,
	AKT_QU,
	DAT_VM,
	DAT_VJ_DATE,
	DAT_VJ_KT,
	DAT_VJ_OSTERN,
	DAT_VVJ_OSTERN,
	DAT_VVJ_DATE
) as
-- Karwoche identifizieren
WITH kar_woche AS(
SELECT 
DISTINCT v01.dat, v01.kjwo, v01.akt_wo
FROM dbp_view.v_tag_1  v01
JOIN dbp_view.v_wupcal_ereignis_zu_1 v02
ON v01.dat = v02.dat
WHERE v02.mandant_Id = 1 
AND v02.ereignis_id = 5 
AND v02.ereignistyp_id = 1 
AND v01.dat >= '2019-01-01') 
-- Zeitraum fuer Ostern definieren 
-- Karwoche - 10 Wochen + 2 Wochen 
, oster_saison_zeitraum AS (
SELECT   v01.dat, 
v01.akt_kj,
v01.kjwo,
DENSE_RANK() OVER (PARTITION BY v01.AKT_KJ ORDER BY v01.dat ASC) AS sort_id_ostertage
FROM dbp_view.v_tag_1 v01
JOIN kar_woche 
ON v01.akt_wo BETWEEN kar_woche.akt_wo -10 AND kar_woche.akt_wo + 2)
-- VJ / VVJ Dat ermitteln 
, ostern_saison_vj_vvj_fakten AS 
(SELECT 
v01.dat,
vj.kjwo AS kjwo_vj_ostern,
vj.dat AS dat_vj_ostern,
vvj.kjwo AS kjwo_vvj_ostern,
vvj.dat AS dat_vvj_ostern
FROM oster_saison_zeitraum v01
LEFT JOIN oster_saison_zeitraum vj
ON v01.akt_kj-1 = vj.akt_kj
AND v01.sort_id_ostertage = vj.sort_id_ostertage
LEFT JOIN oster_saison_zeitraum vvj
ON v01.akt_kj-2 = vvj.akt_kj
AND v01.sort_id_ostertage = vvj.sort_id_ostertage)

   SELECT
   v01.dat,
   v01.kjmo, 
   v01.kjmo_vj, 
   v01.wtag_id, 
   v01.kjwo, 
   v01.kjwo_vj, 
   v01.gjwo, 
   v01.gjwo_vj, 
   v01.wo_dat_von, 
   v01.wo_dat_bis, 
   v01.gjmo, 
   v01.gjmo_vj, 
   v01.kjqu, 
   v01.gjqu, 
   v01.kj, 
   v01.gj, 
   v01.kjtag_id, 
   v01.gjtag_id, 
   v01.kjwo_kl, 
   v01.kjwo_kl_dat_von, 
   v01.kjwo_kl_dat_bis, 
   v01.gjwo_kl, 
   v01.gjwo_kl_dat_von, 
   v01.gjwo_kl_dat_bis, 
   v01.dat_vj, 
   v01.akt_tag, 
   v01.akt_mo, 
   v01.akt_mo_komplett, 
   v01.akt_wo, akt_wo_komplett, 
   v01.akt_gjwo_kl, 
   v01.akt_gjwo_kl_komplett, 
   v01.akt_kjwo_kl, 
   v01.akt_kjwo_kl_komplett, 
   v01.akt_gjqu, 
   v01.akt_gjqu_komplett, 
   v01.akt_kjqu, 
   v01.akt_kjqu_komplett, 
   v01.akt_gj, 
   v01.akt_gj_komplett, 
   v01.akt_kj, 
   v01.akt_kj_komplett, 
   v01.mo_gj, 
   v01.mo_kj, 
   v01.dat_vj-364, 
   v01.akt_mo/3, 
   ADD_MONTHS(v01.dat,-1), 
   ADD_MONTHS(v01.dat,-12),
   --AP0168833/SPEC0213188 sschuecke 25.08.2023 / Erweiterung um Spalte DAT_VJ_KT für Schaltjahre
   v01.dat_vj_kt,
   -- AP0186806/SPEC0228449 steaeblern 29.02.2024 / Saison Reporting fuer Ostern ermittlung der VJ/ VVJ Metriken 
   v02.dat_vj_ostern,
   v02.dat_vvj_ostern,
    -- AP0186806/SPEC0228450 steaeblern 01.03.2024 / Tagesreporting NF - Dat_vvj_kt da derzeit nicht im DM vorhanden
   ADD_MONTHS(v01.dat_vj_kt,-12) AS dat_vvj_kt
   FROM dbp_view.v_tag_1 v01
   LEFT JOIN ostern_saison_vj_vvj_fakten v02
   ON v01.dat = v02.dat;