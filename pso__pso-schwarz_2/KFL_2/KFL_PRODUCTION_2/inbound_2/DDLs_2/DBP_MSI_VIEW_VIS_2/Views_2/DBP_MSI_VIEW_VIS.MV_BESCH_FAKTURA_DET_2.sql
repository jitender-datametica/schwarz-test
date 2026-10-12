CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_BESCH_FAKTURA_DET_2 (
   MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT,
	VZ_NB_ID,
	VZ_WUP_ID,
	ART_ID,
	DAT_FAKTURA,
	FAKTURA_TYP_ID,
	GP_ID,
	MENGE_FAKTURA_BME,
	MENGE_FAKTURA_KOLLI,
	FAKTURA_MENGE_BME,
	FAKTURA_MENGE_BME_RET
)
AS 
   -- FAKT Wareneingang/Retouren aus VZ pro Artikel_2/Filiale
   -- Basis AIS view - FWWS Berichte MSC Fisch / Bio Backshop
   -- 2015-07-14 : INITIAL
   -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]
SELECT
   v01.mandant_id
   , v03.nb_id
   , v03.aktuell_wup_id AS wup_id
   , v01.dat_faktura AS dat
   , v01.nb_id AS vz_nb_id
   , v01.wup_id AS vz_wup_id
   , v01.art_id
   , v01.dat_faktura
   , v02.faktura_typ_id
   , v04.gp_id
   , v01.menge_faktura_bme
   , v01.menge_faktura_kolli
   , CASE
      WHEN v02.faktura_typ_id IN ('N') THEN v01.menge_faktura_bme * -1
      WHEN v02.faktura_typ_id NOT IN ('O', 'S') THEN v01.menge_faktura_bme
      ELSE 0
   END :: DECIMAL(18, 3) AS faktura_menge_bme
   , CASE
      WHEN v02.faktura_typ_id IN ('O') THEN v01.menge_faktura_bme * -1
      WHEN v02.faktura_typ_id IN ('S') THEN v01.menge_faktura_bme
      ELSE 0
   END :: DECIMAL(18, 3) AS faktura_menge_bme_ret
FROM
   dbp_view.v_besch_faktura_det_2 v01
   JOIN dbp_view.v_besch_faktura_2 v02 ON v01.faktura_beleg_id = v02.faktura_beleg_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.dat_faktura_sap = v02.dat_faktura_sap
   AND v02.auftraggeber_id BETWEEN '0000001000'
   AND '0000009999'
   AND v02.fakturaart_id NOT IN ('ZIWU', 'ZIWV')
   JOIN dbp_view.v_wup_2 v03 ON TRY_CAST(v02.auftraggeber_id AS INTEGER) = v03.wup_id
   AND v01.mandant_id = v03.mandant_id
   AND v03.nb_id = 0
   JOIN dbp_view.v_art_gp_zu_per_2 v04 ON v01.art_id = v04.art_id
   AND v01.mandant_id = v04.mandant_id
   AND v01.dat_faktura BETWEEN v04.dat_von
   AND v04.dat_bis
WHERE
   v01.mandant_id = 1
   AND v01.nb_id <> 99;