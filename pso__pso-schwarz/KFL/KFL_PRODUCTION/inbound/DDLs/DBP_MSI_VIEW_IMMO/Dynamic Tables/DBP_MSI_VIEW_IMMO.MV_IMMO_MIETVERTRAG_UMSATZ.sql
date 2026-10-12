CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_MIETVERTRAG_UMSATZ(
	BRANCHE_ID,
	MANDANT_ID,
	MIETVERTRAG_NR,
	MV_INTRENO,
	PARTNER_ID,
	KONZESSIONAER_ID,
	VERTRAGSART_ID,
	KJMO,
	MAX_MELDEREGEL,
	INTERVAL_MONTHS,
	MELDEREGEL,
	RHYTHMUS_ART,
	UMSATZ_BRUTTO,
	UMSATZ_NETTO,
	UMSATZKENNUNG,
	VERSION,
	WRG_ID,
	WRG_TYP_ID,
	KJ,
	AKT_KJ,
	AKT_MO,
	AKT
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS 
-- 06.02.2018 - condition for  MAX of dat_miet_ende has been added
-- 12.02.2018 - condition for  umsatzvereinbarung_per IS NULL has been added
--contracts in national currency
SELECT
   DISTINCT v1.branche_id,
   v1.mandant_id,
   v1.mietvertrag_nr,
   v9.mv_intreno_akt AS mv_intreno,
   v1.partner_id,
   v9.konzessionaer_id_akt AS konzessionaer_id,
   v1.vertragsart_id,
   v2.kjmo,
   v77.melderegel_max AS max_melderegel,
   CASE
      WHEN max_melderegel = v2.melderegel THEN CAST(
         (
            CAST(
               SUBSTR(v2.dat_meldungsintervall_bis, 6, 2) AS INTEGER
            ) - CAST(
               SUBSTR(v2.dat_meldungsintervall_von, 6, 2) AS INTEGER
            ) + 1
         ) AS INTEGER
      )
      ELSE 0
   END AS interval_months,
   v2.melderegel,
   v2.rhythmus_art,
   v2.umsatz_brutto,
   v2.umsatz_netto,
   v2.umsatzkennung,
   v2.VERSION,
   v2.wrg_id,
   v6.wrg_typ_id,
   v8.kj,
   v8.akt_kj,
   v8.akt_mo,
   0 AS akt
FROM
   dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
   INNER JOIN dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2 ON v1.mv_intreno = v2.mv_intreno
   AND v1.mandant_id = v2.mandant_id
   INNER JOIN dbp_msi_view_immo.mv_mandant_wrg_typ_zu v6 ON v1.mandant_id = v6.mandant_id
   AND v2.wrg_id = v6.wrg_id
   AND v6.wrg_typ_id = 1
   INNER JOIN dbp_msi_view_immo.mv_l_kj_monat v8 ON v2.kjmo = v8.kjmo
   JOIN dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9 ON v1.mietvertrag_nr = v9.mietvertrag_nr
   AND v1.mandant_id = v9.mandant_id --JOIN dbp_msi_view_immo.mv_immo_altvertraege_map v21
   --ON v1.mv_intreno=v21.mv_intreno AND v1.mandant_id=v21.mandant_id AND v1.mietvertrag_nr=v21.mietvertrag_nr AND v2.kjmo=v21.kjmo AND v2.wrg_id =v21.wrg_id AND v2.melderegel=v21.melderegel AND v2.VERSION=v21.VERSION AND v2.rhythmus_art=v21.rhythmus_art
   INNER JOIN dbp_msi_view_immo.mv_melderegel_count v77
   ON
         v77.mandant_id = v1.mandant_id
         AND v77.mv_intreno = v2.mv_intreno
         AND v77.kjmo = v2.kjmo
WHERE
   v2.VERSION = (
      SELECT
         MAX(v11.VERSION)
      FROM
         dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v11
      WHERE
         v2.mv_intreno = v11.mv_intreno
         AND v2.kjmo = v11.kjmo
         AND v2.melderegel = v11.melderegel
   )
   AND v1.mv_intreno =(
      SELECT
         MAX(v22.mv_intreno)
      FROM
         dbp_msi_view_immo.mv_immo_altvertraege_map AS v22
      WHERE
         v22.mandant_id = v1.mandant_id
         AND v1.mietvertrag_nr = v22.mietvertrag_nr
         AND v2.kjmo = v22.kjmo
         AND v2.wrg_id = v22.wrg_id
         AND v2.melderegel = v22.melderegel
         AND v2.VERSION = v22.VERSION
   )
   AND v2.nullumsatz <> 'X'
   AND v2.umsatz_netto > 0
   AND v2.rhythmus_art = '0001'
UNION
ALL --contracts in EUR
SELECT
   DISTINCT v1.branche_id,
   v1.mandant_id,
   v1.mietvertrag_nr,
   v9.mv_intreno_akt AS mv_intreno,
   v1.partner_id,
   v9.konzessionaer_id_akt AS konzessionaer_id,
   v1.vertragsart_id,
   v2.kjmo,
   v77.melderegel_max AS max_melderegel,
   CASE
      WHEN max_melderegel = v2.melderegel THEN CAST(
         (
            CAST(
               SUBSTR(v2.dat_meldungsintervall_bis, 6, 2) AS INTEGER
            ) - CAST(
               SUBSTR(v2.dat_meldungsintervall_von, 6, 2) AS INTEGER
            ) + 1
         ) AS INTEGER
      )
      ELSE 0
   END AS interval_months,
   v2.melderegel,
   v2.rhythmus_art,
   v2.umsatz_brutto,
   v2.umsatz_netto / v7.kurs_zu_euro AS umsatz_netto,
   v2.umsatzkennung,
   v2.VERSION,
   'EUR' AS wrg_id,
   0 AS wrg_typ_id,
   v8.kj,
   v8.akt_kj,
   v8.akt_mo,
   0 AS akt
FROM
   dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
   INNER JOIN dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2 ON v1.mv_intreno = v2.mv_intreno
   AND v1.mandant_id = v2.mandant_id
   INNER JOIN dbp_msi_view_immo.mv_mandant_wrg_typ_zu v6 ON v1.mandant_id = v6.mandant_id
   AND v2.wrg_id = v6.wrg_id
   AND v6.wrg_typ_id = 1
   INNER JOIN dbp_msi_view_immo.mv_l_wrg v7 ON v7.wrg_id = v2.wrg_id
   INNER JOIN dbp_msi_view_immo.mv_l_kj_monat v8 ON v2.kjmo = v8.kjmo
   JOIN dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9 ON v1.mietvertrag_nr = v9.mietvertrag_nr
   AND v1.mandant_id = v9.mandant_id --JOIN dbp_msi_view_immo.mv_immo_altvertraege_map v21
   --ON v1.mv_intreno=v21.mv_intreno AND v1.mandant_id=v21.mandant_id AND v1.mietvertrag_nr=v21.mietvertrag_nr AND v2.kjmo=v21.kjmo AND v2.wrg_id =v21.wrg_id AND v2.melderegel=v21.melderegel AND v2.VERSION=v21.VERSION
   INNER JOIN
         dbp_msi_view_immo.mv_melderegel_count v77
      ON
         v77.mandant_id = v1.mandant_id
         AND v77.mv_intreno = v2.mv_intreno
         AND v77.kjmo = v2.kjmo
WHERE
   v2.VERSION = (
      SELECT
         MAX(v11.VERSION)
      FROM
         dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v11
      WHERE
         v2.mv_intreno = v11.mv_intreno
         AND v2.kjmo = v11.kjmo
         AND v2.melderegel = v11.melderegel
   )
   AND v1.mv_intreno =(
      SELECT
         MAX(v22.mv_intreno)
      FROM
         dbp_msi_view_immo.mv_immo_altvertraege_map AS v22
      WHERE
         v22.mandant_id = v1.mandant_id
         AND v1.mietvertrag_nr = v22.mietvertrag_nr
         AND v2.kjmo = v22.kjmo
         AND v2.wrg_id = v22.wrg_id
         AND v2.melderegel = v22.melderegel
         AND v2.VERSION = v22.VERSION
   )
   AND v2.nullumsatz <> 'X'
   AND v2.umsatz_netto > 0
   AND v2.rhythmus_art = '0001';