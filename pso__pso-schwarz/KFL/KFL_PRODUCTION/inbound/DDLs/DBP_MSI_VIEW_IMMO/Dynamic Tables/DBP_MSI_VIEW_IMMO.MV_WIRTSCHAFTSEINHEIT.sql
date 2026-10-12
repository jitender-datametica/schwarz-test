CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_WIRTSCHAFTSEINHEIT(
	MANDANT_ID,
	WE_INTRENO,
	BUCHUNGSKREIS_ID,
	SYSTEM_ID,
	WIRTSCHAFTSEINHEIT_ID,
	WIRTSCHAFTSEINHEIT_BEZ,
	WE_OBJEKT_NR,
	DAT_EROEFFNUNG,
	ANMIETENDE,
	GEPLANTE_EROEFFNUNG,
	DAT_WE_GUELTIG_VON,
	DAT_WE_GUELTIG_BIS,
	GEBIET_ID,
	REGION_ID,
	REGION_BEZ,
	STANDORT,
	ORT,
	OBJEKTLEITER_ID,
	REGIONALLEITER_ID,
	OBJEKTBETREUER_ID,
	PLZ,
	ADRESSE,
	TELEFON_NR,
	FAX_NR,
	BESITZSTATUS_ID,
	WE_REGION,
	OBJEKTART_ID,
	BREITENGRAD,
	LAENGENGRAD
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS -- 2016-10-25 ttez1905; Lookup View fuer Wirtschaftseinheit; Status:Initial/nicht fertig
-- 2017-01-18 ttez1905; system_id mit DEFAULT-Wert 2 als Fremdschluessel zum Buchungskreis aufgenommen.
-- 2017-01-30 ttez1905; JOIN-Bedingung mandant_id bei v1 und v2 hinzugefuegt.
-- 2017-03-13 ttez1905; Spalte Standort hinzugefuegt.
-- 20170601 KMorgenstern breitengrad und laengengrad aus wup uebernommen
-- 20171013 WE_gueltigkeit beruecksichtigt
--20180223 lsvi0303: columns plz. adresse, telefon_nr and fax_nr added
---20180307 dsim0608 column region_bez added
--20180830 lsvi0303: besitzstatus column added
--20180926 lsvi0303: anmietende and geplante eroeffnung added
--20190115 lsvi0303: wirtschaftseinheit_id logic because of 3-digit store in DE (630)
--190401 nfis0811: SPEC0051099 - Erweiterung Objektbetreuer
--190820 nfis0811: SPEC0051099 - buchungskreis_id -> 4-stellig
--191008 cbru1709: join für anmietende erweitert um we_intreno
--191021 cbru1709: Where Bedingung hinzugefügt für WE Gültigkeit Datum
--200113 cbru1709: Min bei Anmietende eingebaut
--211108 richternic: Ermittlung geplante Eroeffnung angepasst 
--220720 richternic: SPEC0158746 MAX Eroeffnung -> damit pro Standort nur 1 Datum vorhanden ist und keine Dopplungen entstehen 
SELECT
  v0.mandant_id,
  v0.we_intreno,
  CASE
    WHEN v0.buchungskreis_id < 10 THEN '000' || TRIM(v0.buchungskreis_id)
    WHEN v0.buchungskreis_id < 100 THEN '00' || TRIM(v0.buchungskreis_id)
    WHEN v0.buchungskreis_id < 1000 THEN '0' || TRIM(v0.buchungskreis_id)
    ELSE '' || TRIM(v0.buchungskreis_id)
  END AS buchungskreis_id,
  2 AS system_id,
  CASE
    WHEN LENGTH(v0.wirtschaftseinheit_id) = 3 THEN '0' || v0.wirtschaftseinheit_id
    ELSE v0.wirtschaftseinheit_id
  END AS wirtschaftseinheit_id,
  v0.wirtschaftseinheit_bez,
  v0.we_objekt_nr,
  v0.dat_eroeffnung,
  v14.anmietende,
  v15.geplante_eroeffnung,
  v0.dat_we_gueltig_von,
  v0.dat_we_gueltig_bis,
  COALESCE(v2.gebiet_id, 0) AS gebiet_id,
  COALESCE(v0.region_id, 'n.v.') AS region_id,
  COALESCE(v22.region_bez, 'n.v.') AS region_bez,
  v0.standort,
  v0.ort,
  COALESCE(v1.partner_id, 'n.v.') AS objektleiter_id,
  COALESCE(v2.partner_id, 'n.v.') AS regionalleiter_id,
  COALESCE(v3.partner_id, 'n.v.') AS objektbetreuer_id,
  v0.plz,
  v0.strasse || ' ' || v0.haus_nr AS adresse,
  v12.wup_telefon AS telefon_nr,
  v12.wup_fax AS fax_nr,
  v0.besitzstatus_id,
  COALESCE(v0.we_region, 'n.v.') AS we_region,
  COALESCE(v0.objektart_id, 'n.v.') AS objektart_id,
  COALESCE(w.breitengrad, 0) AS breitengrad,
  COALESCE(w.laengengrad, 0) AS laengengrad
FROM
  dbp_view.v_immo_wirtschaftseinheit v0
  LEFT OUTER JOIN (
    -- Hole alle Objektleiter
    SELECT
      --v00.mandant_id
      v00.partner_id,
      v01.we_intreno
    FROM
      dbp_view.v_immo_l_partner v00
      INNER JOIN dbp_view.v_immo_we_partner_rolle_zu_per v01 ON --v00.mandant_id = v01.mandant_id AND 
      v00.partner_id = v01.partner_id
    WHERE
      CURRENT_DATE BETWEEN v01.dat_von
      AND v01.dat_bis
      AND v01.rolle_kz = 'ZI0104'
  ) v1 ON v0.we_intreno = v1.we_intreno
  LEFT OUTER JOIN (
    -- Hole alle Regionalleiter
    SELECT
      --v10.mandant_id
      v10.partner_id,
      v11.we_intreno,
      v10.gebiet_id
    FROM
      dbp_view.v_immo_l_partner v10
      INNER JOIN dbp_view.v_immo_we_partner_rolle_zu_per v11 ON --v10.mandant_id = v11.mandant_id AND 
      v10.partner_id = v11.partner_id
    WHERE
      "CURRENT_DATE" BETWEEN v11.dat_von
      AND v11.dat_bis
      AND v11.rolle_kz = 'ZI0105'
  ) v2 ON v0.we_intreno = v2.we_intreno
  LEFT OUTER JOIN (
    -- Hole alle Objektbetreuer
    SELECT
      --v00.mandant_id
      v00.partner_id,
      v01.we_intreno
    FROM
      dbp_view.v_immo_l_partner v00
      INNER JOIN dbp_view.v_immo_we_partner_rolle_zu_per v01 ON --v00.mandant_id = v01.mandant_id AND 
      v00.partner_id = v01.partner_id
    WHERE
      "CURRENT_DATE" BETWEEN v01.dat_von
      AND v01.dat_bis
      AND v01.rolle_kz = 'ZI0120'
  ) v3 ON v0.we_intreno = v3.we_intreno
  LEFT JOIN dbp_view.v_wup w ON v0.mandant_id = w.mandant_id
  AND v0.wirtschaftseinheit_id = w.wup_id
  LEFT OUTER JOIN --dbe_msi_view_immo.mv_l_region - in order to avoid cross referencing
  (
    SELECT
      v1.mandant_id,
      v1.region_id,
      v2.spr_id,
      v2.region_bez
    FROM
      dbp_view.v_immo_l_region v1
      JOIN dbp_view.v_immo_region_spr_zu v2 ON v1.mandant_id = v2.mandant_id
      AND v1.region_id = v2.region_id
    WHERE
      v2.spr_id = 22
    UNION
    ALL
    SELECT
      DISTINCT 0 AS mandant_id,
      'n.v' AS region_id,
      0 AS spr_id,
      'n.v' AS region_bez
    FROM
      dbp_view.v_immo_l_region
  ) AS v22 ON v0.mandant_id = v22.mandant_id
  AND v0.region_id = v22.region_id
  LEFT JOIN dbp_view.v_vaus_wup AS v12 ON v0.mandant_id = v12.mandant_id
  AND v0.wirtschaftseinheit_id = v12.wup_id
  LEFT JOIN (
    SELECT
      t3.mandant_id,
      t3.wirtschaftseinheit_id,
      t3.we_intreno,
      MIN(
        CASE
          WHEN t2.dat_miet_ende < t2.dat_naechstes_vertragsende THEN t2.dat_miet_ende
          ELSE t2.dat_naechstes_vertragsende
        END
      ) AS anmietende
    FROM
      dbp_view.v_immo_mietvertrag_we_zu_per t1
      JOIN dbp_view.v_immo_mietvertrag_per t2 ON t1.mandant_id = t2.mandant_id
      AND t1.mv_intreno = t2.mv_intreno
      JOIN dbp_view.v_immo_wirtschaftseinheit t3 ON t1.we_intreno = t3.we_intreno
      AND t1.mandant_id = t3.mandant_id
    WHERE
      CURRENT_DATE BETWEEN t1.dat_von
      AND t1.dat_bis
      AND CURRENT_DATE BETWEEN t2.dat_miet_beginn
      AND t2.dat_miet_ende
      AND t2.vertragsart_id = 100
      AND t2.vertragsgegenstand_id = 17
      AND CURRENT_DATE BETWEEN t3.dat_we_gueltig_von
      AND t3.dat_we_gueltig_bis
    GROUP BY
      t3.mandant_id,
      t3.wirtschaftseinheit_id,
      t3.we_intreno
  ) AS v14 ON v0.mandant_id = v14.mandant_id
  AND v0.wirtschaftseinheit_id = v14.wirtschaftseinheit_id
  AND v0.we_intreno = v14.we_intreno
  LEFT JOIN (
    SELECT
      t2.mandant_id,
      t2.wup_id,
      MAX(t1.dat_ende_vorhersage) AS geplante_eroeffnung
    FROM
      dbp_view.v_cpr_projekt_bauabschnitt_zu t1
      JOIN dbp_view.v_cpr_projekt_per t2 ON t1.projekt_id = t2.projekt_id
      JOIN dbp_view.v_rpm_element_per t3 ON t2.cpr_ext_id = t3.projekt_id
      AND t2.dat_bis = t3.dat_bis
      AND t2.mandant_id = t3.mandant_id
      AND t2.wup_id = t3.wup_id
    WHERE
      t1.cpr_suchfeld_id = 410
      AND t1.sort_id = 1
      AND t2.massnahme_id = 'XP'
      AND cpr_systemstatus1_id IN(1, 2)
      AND t2.dat_bis = '9999-12-31'
      AND t3.rpm_status_id NOT IN (3, 5, 6, 14) -- projects with status completed/aborted/suspended/cancellation not considered
    GROUP BY
      t2.mandant_id,
      t2.wup_id
  ) AS v15 ON v0.mandant_id = v15.mandant_id
  AND v0.wirtschaftseinheit_id = v15.wup_id
WHERE
  Current_Date BETWEEN v0.dat_we_gueltig_von
  AND v0.dat_we_gueltig_bis;