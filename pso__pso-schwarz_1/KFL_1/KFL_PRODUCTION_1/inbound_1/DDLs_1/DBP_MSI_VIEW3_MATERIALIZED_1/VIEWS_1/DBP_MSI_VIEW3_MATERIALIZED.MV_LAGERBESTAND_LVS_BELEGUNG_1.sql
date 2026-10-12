create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LAGERBESTAND_LVS_BELEGUNG_1(
	MANDANT_ID,
	LAGERPLATZ_ID,
	LAGERNUMMER_ID,
	LAGERTYP_ID,
	ART_ID,
	DAT,
	VOLUMEN_KOLLI,
	VOLUMEN_PALETTE,
	VOLUMEN_BELEGT,
	BESTANDSMENGE_IN_PALETTEN
) as
SELECT
dt1.mandant_id,
dt1.lagerplatz_id,
dt1.lagernummer_id,
dt1.lagertyp_id,
dt1.art_id,
dt1.dat,
MAX(dt1.volumen_kolli) AS volumen_kolli,
MAX(dt1.volumen_palette) AS volumen_palette,
CASE
WHEN dt1.lagertyp_id IN ('TR1', 'RL1', '916') OR SUBSTR( dt1.lagertyp_id, 1, 1) = 'G' THEN MAX(dt1.volumen_kolli)
ELSE MAX(dt1.volumen_palette) END AS volumen_belegt,
MAX(dt1.bestandsmenge_in_paletten) AS bestandsmenge_in_paletten
FROM (SELECT
t1.mandant_id,
t1.lagerplatz_id,
t1.lagernummer_id,
t1.lagertyp_id,
t1.art_id,
t1.dat,









MAX(CASE
WHEN t2.zl_kolli_menge_einh_id = t3.altnv_menge_einh_id THEN t3.laenge * t3.breite * t3.hoehe END) OVER (PARTITION BY t1.mandant_id, t1.dat, t1.art_id) AS volumen_kolli,





CASE
WHEN t2.paletten_faktor_einh_id = t3.altnv_menge_einh_id THEN CASE
WHEN t3.laenge IN (0, NULL) OR
t3.breite IN (0, NULL) OR
t3.hoehe  IN (0, NULL) THEN CASE
WHEN is_integer(to_variant(paletten_faktor_einh_id)) = true THEN t2.paletten_faktor_einh_id_num / t2.zl_kolli_menge_einh_id_num * volumen_kolli


ELSE 1/CAST(t3.umrech_faktor AS DECIMAL(18,14)) / t2.zl_kolli_menge_einh_id_num * volumen_kolli END

ELSE t3.laenge * t3.breite * t3.hoehe END END AS volumen_palette,
CASE
WHEN t1.lagertyp_id = 'TR1' OR SUBSTR( t1.lagertyp_id, 1, 1) = 'G' THEN menge_lgbest_lvs_palette
ELSE 1 END AS bestandsmenge_in_paletten
FROM dbp_view.v_lagerbestand_lvs_1 t1_1
LEFT JOIN (SELECT
a1.*,


CASE
WHEN is_integer(to_variant(zl_kolli_menge_einh_id)) = true THEN zl_kolli_menge_einh_id
ELSE NULL END AS zl_kolli_menge_einh_id_num,
CASE
WHEN is_integer(to_variant(paletten_faktor_einh_id)) = true THEN paletten_faktor_einh_id
ELSE NULL END AS paletten_faktor_einh_id_num
FROM dbp_view.v_art_vorschlagswert_per_1 a1) t2
ON t1.mandant_id = t2.mandant_id
AND t1.art_id = t2.art_id
AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis

LEFT JOIN dbp_view.v_art_umrechnung_faktor_per_1 t3
ON t1.mandant_id = t3.mandant_id
AND t1.art_id = t3.art_id
AND t1.dat BETWEEN t3.dat_von AND t3.dat_bis
) dt1

GROUP BY dt1.mandant_id
,dt1.lagerplatz_id
,dt1.lagernummer_id
,dt1.lagertyp_id
,dt1.art_id
,dt1.dat;