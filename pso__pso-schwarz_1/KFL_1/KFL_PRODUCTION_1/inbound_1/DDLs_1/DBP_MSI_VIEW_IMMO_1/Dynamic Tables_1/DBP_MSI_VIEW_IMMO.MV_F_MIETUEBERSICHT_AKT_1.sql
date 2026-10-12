CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_F_MIETUEBERSICHT_AKT_1(
  MANDANT_ID,
  DAT_MO_GUELTIG_VON,
  DAT_MO_GUELTIG_BIS,
  DAT_WE_GUELTIG_VON,
  DAT_WE_GUELTIG_BIS,
  MO_INTRENO,
  MO_RUECKGABE_FG,
  MV_INTRENO,
  BRANCHE_ID,
  KONZESSIONAER_ID,
  WRG_ID,
  WRG_TYP_ID,
  MO_DAT_STATUS_VON,
  MO_DAT_STATUS_BIS,
  MO_STATUS_ID,
  MO_STATUS_VORMONAT_ID,
  KZ_NEU_HINZUGEKOMMEN,
  F_MO_STATUS,
  F_MV_ANSCHLUSS_MIETVERTRAG,
  F_ENDE_12MON_KZ,
  F_ENDE_24MON_KZ,
  F_MIETE_PA_WRG,
  F_MIETE_UMSATZ_PROZENT,
  F_MIETE_UMSATZ_PROZENT_GREY_FG,
  F_MO_GROESSE,
  F_MV_LAUFZEIT_MONATE,
  F_ANZ_MV,
  F_MV_AKT_FLAG,
  LEERSTAND_FG
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   WITH with_kurs AS (
    SELECT von_wrg_id, umrechnungskurs
   FROM dbp_view.v_kurs_1
      WHERE dat_bis = '9999-12-31' AND kurstyp_id=3 ),
   with_mo_messung AS (
   SELECT mandant_id, mo_intreno, groesse
   FROM dbp_view.v_immo_mietobjekt_messung_1
   WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
   AND bemessung_art_id IN ('0300','0310','0320','0380'))



 
 
 
 
 
 SELECT
 v0.mandant_id, CASE WHEN v2.dat_mo_gueltig_von='1900-01-01' THEN v9.dat_we_gueltig_von ELSE v2.dat_mo_gueltig_von END AS dat_mo_gueltig_von, v2.dat_mo_gueltig_bis, v9.dat_we_gueltig_von, v9.dat_we_gueltig_bis, v1.mo_intreno, CASE WHEN v1.dat_bis < CURRENT_DATE THEN 1 ELSE 0 END AS mo_rueckgabe_fg, v0.mv_intreno, CASE WHEN v0.branche_id <> 0 THEN v0.branche_id ELSE v2.branche_id END AS branche_id, v0.partner_id AS konzessionaer_id, CASE WHEN v3.wrg_id IS NULL THEN v6.von_wrg_id
   WHEN v6.von_wrg_id= 'EUR' THEN COALESCE(v3.wrg_id, 'EUR') ELSE 'EUR' END AS wrg_id, CASE WHEN v3.wrg_id IS NULL THEN v5.wrg_typ_id
   WHEN v5.wrg_typ_id = 0 THEN 1 ELSE 0 END AS wrg_typ_id, v4.dat_status_von AS mo_dat_status_von, v4.dat_status_bis AS mo_dat_status_bis, v4.mo_status_id, v4.mo_status_vormonat_id
   
  , CASE WHEN TO_VARCHAR(mo_status_id) = mo_status_vormonat_id OR (TO_VARCHAR(mo_status_id) = '0' AND mo_status_vormonat_id = '-') THEN 'Aktueller Status_1' ELSE 'hinzugekommen im letzten Monat_1' END AS kz_neu_hinzugekommen
   , mo_status_vormonat_id  || '/' || CAST(v4.mo_status_id AS CHAR(1)) AS f_mo_status, v0.anschluss_mietvertrag AS f_mv_anschluss_mietvertrag, CASE WHEN dat_miet_ende - CURRENT_DATE <= 365 THEN 1 ELSE 0 END AS f_ende_12mon_kz, CASE WHEN dat_miet_ende - CURRENT_DATE <= 730 THEN 1 ELSE 0 END AS f_ende_24mon_kz, CASE WHEN v3.wrg_id= 'EUR' THEN v3.miete_per_anno ELSE (v3.miete_per_anno * v6.umrechnungskurs) END AS f_miete_pa_wrg, v11.miete_umsatz_prozent AS f_miete_umsatz_prozent, v11.flag_grey, v20.groesse AS f_mo_groesse, v0.anz_laufzeit_monate AS f_mv_laufzeit_monate, 1 AS f_anz_mv, CASE WHEN CURRENT_DATE BETWEEN v0.dat_miet_beginn AND v0.dat_miet_ende THEN 1 ELSE 0 END AS f_mv_akt_flag, CASE WHEN (mo_status_id IN (2,3) AND CURRENT_DATE <= v0.dat_miet_ende) THEN 1
   WHEN mo_status_id IN(0,6) THEN 1
   ELSE 0 END AS leerstand_fg
   FROM dbp_view.v_immo_mietvertrag_per_1 v0
   JOIN dbp_view.v_immo_mietvertrag_mo_zu_per_1 v1
   ON v0.mandant_id = v1.mandant_id AND v0.mv_intreno = v1.mv_intreno
   LEFT JOIN dbp_msi_view_immo.mv_immo_mietvertrag_kondition_per_1 v3
   ON v3.mandant_id = v0.mandant_id AND v3.mv_intreno = v0.mv_intreno AND v3.mo_intreno = v1.mo_intreno
   JOIN dbp_view.v_immo_mietobjekt_1 v2
   ON v1.mandant_id = v2.mandant_id AND v1.mo_intreno = v2.mo_intreno
   LEFT JOIN with_mo_messung v20
   ON v1.mandant_id = v20.mandant_id AND v1.mo_intreno = v20.mo_intreno
   JOIN dbp_msi_view_immo.mv_mo_status_historie_1 v4
   ON v0.mandant_id = v4.mandant_id AND v0.mv_intreno = v4.mv_intreno AND v1.mo_intreno = v4.mo_intreno AND v4.mo_status_id NOT IN (0,2,3,6)
   JOIN dbp_view.v_mandant_wrg_typ_zu_1 v5
   ON v0.mandant_id = v5.mandant_id
   JOIN with_kurs v6
   ON v5.wrg_id = v6.von_wrg_id
   JOIN dbp_view.v_immo_wirtschaftseinheit_1 AS v9
   ON v2.we_intreno=v9.we_intreno AND v2.mandant_id=v9.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_immo_umsatzmietvereinbarung_1 v11
   ON v0.mv_intreno=v11.mv_intreno
   UNION ALL
   
   
   
   
   SELECT
   v0.mandant_id, CASE WHEN v0.dat_mo_gueltig_von='1900-01-01' THEN v9.dat_we_gueltig_von ELSE v0.dat_mo_gueltig_von END AS dat_mo_gueltig_von, v0.dat_mo_gueltig_bis, v9.dat_we_gueltig_von, v9.dat_we_gueltig_bis, v0.mo_intreno, 0 AS mo_rueckgabe_fg, '' AS mv_intreno, v0.branche_id, '' AS konzessionaer_id, CASE WHEN v3.wrg_id IS NULL THEN v6.von_wrg_id
   WHEN v6.von_wrg_id= 'EUR' THEN COALESCE(v3.wrg_id, 'EUR') ELSE 'EUR' END AS wrg_id, CASE WHEN v3.wrg_id IS NULL THEN v5.wrg_typ_id
   WHEN v5.wrg_typ_id = 0 THEN 1 ELSE 0 END AS wrg_typ_id, v4.dat_status_von AS mo_dat_status_von, v4.dat_status_bis AS mo_dat_status_bis, v4.mo_status_id, v4.mo_status_vormonat_id
   
  , CASE WHEN TO_VARCHAR(mo_status_id) = mo_status_vormonat_id OR (TO_VARCHAR(mo_status_id) = '0' AND mo_status_vormonat_id = '-') THEN 'Aktueller Status_1' ELSE 'hinzugekommen im letzten Monat_1' END AS kz_neu_hinzugekommen
   , mo_status_vormonat_id  || '/' || CAST(v4.mo_status_id AS CHAR(1)) AS f_mo_status, '' AS f_mv_anschluss_mietvertrag, 0 AS f_ende_12mon_kz, 0 AS f_ende_24mon_kz, CASE WHEN v3.wrg_id= 'EUR' THEN v3.miete_per_anno ELSE (v3.miete_per_anno * v6.umrechnungskurs) END AS f_miete_pa_wrg, v8.groesse AS f_miete_umsatz_prozent, 0 AS flag_grey, v20.groesse AS f_mo_groesse, NULL AS f_mv_laufzeit_monate, 0 AS f_anz_mv, CASE WHEN v4.mo_typ_id=30 THEN 1 ELSE 0 END AS f_mv_akt_flag, CASE WHEN v4.mo_typ_id=30 THEN 0 ELSE 1 END AS leerstand_fg
   FROM dbp_view.v_immo_mietobjekt_1 v0
   LEFT JOIN with_mo_messung v20
   ON v0.mandant_id = v20.mandant_id AND v0.mo_intreno = v20.mo_intreno
   LEFT JOIN dbp_msi_view_immo.mv_immo_mietobjekt_kondition_per_1 v3
   ON v3.mandant_id = v0.mandant_id AND v3.mo_intreno = v0.mo_intreno
   JOIN dbp_msi_view_immo.mv_mo_status_historie_1 v4
   ON v0.mandant_id = v4.mandant_id AND v0.mo_intreno = v4.mo_intreno AND v4.mo_status_id = 0
   LEFT JOIN dbp_view.v_immo_mietobjekt_messung_1 v8
   ON v0.mandant_id = v8.mandant_id AND v0.mo_intreno = v8.mo_intreno AND CURRENT_DATE BETWEEN v8.dat_von AND v8.dat_bis AND v8.bemessung_art_id IN ('0902')
   JOIN dbp_view.v_mandant_wrg_typ_zu_1 v5
   ON v0.mandant_id = v5.mandant_id
   JOIN with_kurs v6
   ON v5.wrg_id = v6.von_wrg_id
   JOIN dbp_view.v_immo_wirtschaftseinheit_1 AS v9
   ON v0.we_intreno=v9.we_intreno AND v0.mandant_id=v9.mandant_id
   UNION ALL
   
   
   
   SELECT
   v0.mandant_id, CASE WHEN v0.dat_mo_gueltig_von='1900-01-01'THEN v9.dat_we_gueltig_von ELSE v0.dat_mo_gueltig_von END AS dat_mo_gueltig_von, v0.dat_mo_gueltig_bis, v9.dat_we_gueltig_von, v9.dat_we_gueltig_bis, v0.mo_intreno, CASE WHEN v2.dat_bis < CURRENT_DATE THEN 1 ELSE 0 END AS mo_rueckgabe_fg, v4.mv_intreno AS mv_intreno, CASE WHEN v7.branche_id <> 0 THEN v7.branche_id ELSE v0.branche_id END AS branche_id, v7.partner_id AS konzessionaer_id, CASE WHEN v3.wrg_id IS NULL THEN v6.von_wrg_id
   WHEN v6.von_wrg_id= 'EUR' THEN COALESCE(v3.wrg_id, 'EUR') ELSE 'EUR' END AS wrg_id, CASE WHEN v3.wrg_id IS NULL THEN v5.wrg_typ_id
   WHEN v5.wrg_typ_id = 0 THEN 1 ELSE 0 END AS wrg_typ_id, v4.dat_status_von AS mo_dat_status_von, v4.dat_status_bis AS mo_dat_status_bis, v4.mo_status_id, v4.mo_status_vormonat_id
   
  , CASE WHEN TO_VARCHAR(mo_status_id) = mo_status_vormonat_id OR (TO_VARCHAR(mo_status_id) = '0' AND mo_status_vormonat_id = '-') THEN 'Aktueller Status_1' ELSE 'hinzugekommen im letzten Monat_1' END AS kz_neu_hinzugekommen
   , mo_status_vormonat_id  || '/' || CAST(v4.mo_status_id AS CHAR(1)) AS f_mo_status, v7.anschluss_mietvertrag AS f_mv_anschluss_mietvertrag, CASE WHEN dat_miet_ende - CURRENT_DATE <= 365 THEN 1 ELSE 0 END AS f_ende_12mon_kz, CASE WHEN dat_miet_ende - CURRENT_DATE <= 730 THEN 1 ELSE 0 END AS f_ende_24mon_kz, CASE WHEN v3.wrg_id= 'EUR' THEN v3.miete_per_anno ELSE (v3.miete_per_anno * v6.umrechnungskurs) END AS f_miete_pa_wrg, v11.miete_umsatz_prozent AS f_miete_umsatz_prozent, v11.flag_grey, v20.groesse AS f_mo_groesse, v7.anz_laufzeit_monate AS f_mv_laufzeit_monate, 1 AS f_anz_mv, CASE WHEN CURRENT_DATE BETWEEN v7.dat_miet_beginn AND v7.dat_miet_ende THEN 1 ELSE 0 END AS f_mv_akt_flag, CASE WHEN (mo_status_id IN (2,3) AND CURRENT_DATE <= v7.dat_miet_ende) THEN 1
   WHEN mo_status_id IN(0,6) THEN 1
   ELSE 0 END AS leerstand_fg
   FROM dbp_view.v_immo_mietobjekt_1 v0
   LEFT JOIN with_mo_messung v20
   ON v0.mandant_id = v20.mandant_id AND v0.mo_intreno = v20.mo_intreno
   LEFT JOIN dbp_msi_view_immo.mv_immo_mietobjekt_kondition_per_1 v3
   ON v3.mandant_id = v0.mandant_id AND v3.mo_intreno = v0.mo_intreno
   










   JOIN
   dbp_view.v_immo_mietvertrag_mo_zu_per_1 v2
   ON v2.mandant_id = v0.mandant_id 
   AND v2.mo_intreno = v0.mo_intreno
   JOIN dbp_msi_view_immo.mv_mo_status_historie_1 v4
   ON v2.mandant_id = v4.mandant_id AND v2.mo_intreno = v4.mo_intreno AND v2.mv_intreno = v4.mv_intreno AND v4.mo_status_id = 6
   

   JOIN
   dbp_view.v_immo_mietvertrag_per_1 v7
   ON v7.mandant_id = v2.mandant_id AND v7.mv_intreno = v2.mv_intreno
   LEFT JOIN dbp_view.v_immo_mietobjekt_messung_1 v8
   ON v0.mandant_id = v8.mandant_id AND v0.mo_intreno = v8.mo_intreno AND CURRENT_DATE BETWEEN v8.dat_von AND v8.dat_bis AND v8.bemessung_art_id IN ('0902')
   JOIN dbp_view.v_mandant_wrg_typ_zu_1 v5
   ON v0.mandant_id = v5.mandant_id
   JOIN with_kurs v6
   ON v5.wrg_id = v6.von_wrg_id
   JOIN dbp_view.v_immo_wirtschaftseinheit_1 AS v9
   ON v0.we_intreno=v9.we_intreno AND v0.mandant_id=v9.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_immo_umsatzmietvereinbarung_1 v11
   ON v4.mv_intreno=v11.mv_intreno
   UNION ALL
   
   
   
   
   SELECT
   v0.mandant_id, CASE WHEN v2.dat_mo_gueltig_von= '1900-01-01' THEN v9.dat_we_gueltig_von ELSE v2.dat_mo_gueltig_von END AS dat_mo_gueltig_von, v2.dat_mo_gueltig_bis, v9.dat_we_gueltig_von, v9.dat_we_gueltig_bis, v1.mo_intreno, CASE WHEN v1.dat_bis < CURRENT_DATE THEN 1 ELSE 0 END AS mo_rueckgabe_fg, v0.mv_intreno, CASE WHEN v0.branche_id <> 0 THEN v0.branche_id ELSE v2.branche_id END AS branche_id, v0.partner_id AS konzessionaer_id, CASE WHEN v3.wrg_id IS NULL THEN v6.von_wrg_id
   WHEN v6.von_wrg_id= 'EUR' THEN COALESCE(v3.wrg_id, 'EUR') ELSE 'EUR' END AS wrg_id, CASE WHEN v3.wrg_id IS NULL THEN v5.wrg_typ_id
   WHEN v5.wrg_typ_id = 0 THEN 1 ELSE 0 END AS wrg_typ_id, v4.dat_status_von AS mo_dat_status_von, v4.dat_status_bis AS mo_dat_status_bis, v4.mo_status_id, v4.mo_status_vormonat_id
   
  , CASE WHEN TO_VARCHAR(mo_status_id) = mo_status_vormonat_id OR (TO_VARCHAR(mo_status_id) = '0' AND mo_status_vormonat_id = '-') THEN 'Aktueller Status_1' ELSE 'hinzugekommen im letzten Monat_1' END AS kz_neu_hinzugekommen
   , mo_status_vormonat_id  || '/' || CAST(v4.mo_status_id AS CHAR(1)) AS f_mo_status, v0.anschluss_mietvertrag AS f_mv_anschluss_mietvertrag, CASE WHEN dat_miet_ende - CURRENT_DATE <= 365 THEN 1 ELSE 0 END AS f_ende_12mon_kz, CASE WHEN dat_miet_ende - CURRENT_DATE <= 730 THEN 1 ELSE 0 END AS f_ende_24mon_kz, CASE WHEN v3.wrg_id= 'EUR' THEN v3.miete_per_anno ELSE (v3.miete_per_anno * v6.umrechnungskurs) END AS f_miete_pa_wrg, v11.miete_umsatz_prozent AS f_miete_umsatz_prozent, v11.flag_grey, v20.groesse AS f_mo_groesse, v0.anz_laufzeit_monate AS f_mv_laufzeit_monate, 1 AS f_anz_mv, CASE WHEN CURRENT_DATE BETWEEN v0.dat_miet_beginn AND v0.dat_miet_ende THEN 1 ELSE 0 END AS f_mv_akt_flag, CASE WHEN (mo_status_id IN (2,3) AND CURRENT_DATE <= v0.dat_miet_ende) THEN 1
   WHEN mo_status_id IN(0,6) THEN 1
   ELSE 0 END AS leerstand_fg
   FROM dbp_view.v_immo_mietvertrag_per_1 v0
   JOIN (SELECT v101.mandant_id, v101.mo_intreno, v101.mv_intreno, v101.dat_von, v101.dat_bis
   FROM dbp_view.v_immo_mietvertrag_mo_zu_per_1 v101
   JOIN (SELECT mandant_id,  mv_intreno, MAX(dat_von) AS dat_von, MAX(dat_bis) AS dat_bis
   FROM dbp_view.v_immo_mietvertrag_mo_zu_per_1
   GROUP BY mandant_id,  mv_intreno
  ) v111
   ON v101.mandant_id = v111.mandant_id AND v101.mv_intreno = v111.mv_intreno AND v101.dat_bis = v111.dat_bis
   ) v1
   ON v0.mandant_id = v1.mandant_id AND v0.mv_intreno = v1.mv_intreno
   LEFT JOIN dbp_msi_view_immo.mv_immo_mietvertrag_kondition_per_1 v3
   ON v3.mandant_id = v0.mandant_id AND v3.mv_intreno = v0.mv_intreno AND v3.mo_intreno = v1.mo_intreno
   JOIN dbp_view.v_immo_mietobjekt_1 v2
   ON v1.mandant_id = v2.mandant_id AND v1.mo_intreno = v2.mo_intreno
   LEFT JOIN with_mo_messung v20
   ON v1.mandant_id = v20.mandant_id AND v1.mo_intreno = v20.mo_intreno
   JOIN dbp_msi_view_immo.mv_mo_status_historie_1 v4
   ON v0.mandant_id = v4.mandant_id AND v0.mv_intreno = v4.mv_intreno AND v1.mo_intreno = v4.mo_intreno AND v4.mo_status_id IN (2,3)
   JOIN dbp_view.v_mandant_wrg_typ_zu_1 v5
   ON v0.mandant_id = v5.mandant_id
   JOIN with_kurs v6
   ON v5.wrg_id = v6.von_wrg_id
   JOIN dbp_view.v_immo_wirtschaftseinheit_1 AS v9
   ON v2.we_intreno=v9.we_intreno AND v2.mandant_id=v9.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_immo_umsatzmietvereinbarung_1 v11
   ON v0.mv_intreno=v11.mv_intreno;
