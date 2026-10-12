create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_L_LAGERPLATZ_2(
	LAGERPLATZ_ID,
	LAGERNUMMER_ID,
	MANDANT_ID,
	LAGERTYP_ID,
	WUP_ID,
	NB_ID,
	LAGERBEREICH_ID,
	DAT_BIS,
	DAT_VON,
	EINLAGER_SPERR_FG,
	AUSLAGER_SPERR_FG,
	ANZAHL_QUANT,
	KOMM_BEREICH,
	GANG_ID,
	BRAND_ABSCHNITT_ID,
	LAGERPLATZ_TYP_ID,
	LAGERPLATZ_GEWICHT_MAX,
	LAGERPLATZ_EBENE,
	SPERRGRUND_ID
) as
   SELECT

    lagerplatz_id
   ,lagernummer_id
   ,mandant_id
   ,lagertyp_id
   ,wup_id, nb_id
   ,lagerbereich_id
   ,dat_bis
   ,dat_von
   ,einlager_sperr_fg
   ,auslager_sperr_fg
   ,anzahl_quant
   ,CASE WHEN TRIM(COALESCE(komm_bereich,'')) <> '' THEN komm_bereich ELSE 'kein Kommbereich' END AS komm_bereich
   ,CASE WHEN SUBSTR(lagerplatz_id,4,1) = '-' THEN LEFT(lagerplatz_id,3) ELSE 'kein Gang' END AS gang_id
   ,CAST(COALESCE(brand_abschnitt_id,'-1') AS CHAR(2) ) AS brand_abschnitt_id
   ,lagerplatz_typ_id
   ,lagerplatz_gewicht_max
   ,lagerplatz_ebene
   ,sperrgrund_id
   FROM dbp_view.v_l_lagerplatz_2
    WHERE EXTRACT(YEAR FROM dat_bis) >= YEAR(CURRENT_TIMESTAMP) - 2;