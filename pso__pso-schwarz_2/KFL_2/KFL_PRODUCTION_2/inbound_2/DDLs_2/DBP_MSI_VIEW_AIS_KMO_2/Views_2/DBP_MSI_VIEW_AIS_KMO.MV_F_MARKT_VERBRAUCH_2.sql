CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_F_MARKT_VERBRAUCH_2
(
 mandant_id
,wup_id
,nb_id
,art_id
,dat
,gp_id
,markt_verbrauch_menge
,markt_verbrauch_ekn2
,markt_verbrauch_ekn4
/* Folgende Spalten nicht in MSI referenzieren */
--,_umkurs
)
AS
   SELECT
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.art_id,
   v01.dat,
   v01.gp_id,
   v01.menge                                                  AS markt_verbrauch_menge,
    -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   --CASE WHEN v02.wrg_typ_id = 1 THEN CAST (1 AS NUMBER(38,5)) ELSE v03.umrechnungskurs END AS _umkurs,
   --CAST (((v01.umsatz_netto * v04.kein_zekp_fg * v04.ek_nettonetto) + (v01.menge * (1-v04.kein_zekp_fg) * v04.ek_nettonetto))* _umkurs AS DECIMAL(18,4)) AS markt_verbrauch_ekn2,
   --CAST (((v01.umsatz_netto * v04.kein_zekp_fg * v04.einstandspreis)+ (v01.menge * (1-v04.kein_zekp_fg) * v04.einstandspreis)) * _umkurs AS DECIMAL(18,4)) AS markt_verbrauch_ekn4
  
   CAST (CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0
              THEN ((v01.diff_umsatz_netto_konz * v04.kein_zekp_fg * v01.diff_ek_nettonetto_konz) + (v01.menge * (1-v04.kein_zekp_fg) * v01.diff_ek_nettonetto_konz))
              WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1
              THEN ((v01.umsatz_netto * v04.kein_zekp_fg * v01.ek_nettonetto) + (v01.menge * (1-v04.kein_zekp_fg) * v01.ek_nettonetto * umrechnungskurs_hist))
              ELSE ((v01.umsatz_netto * v04.kein_zekp_fg * v01.ek_nettonetto) + (v01.menge * (1-v04.kein_zekp_fg) * v01.ek_nettonetto))
              END AS DECIMAL(18,4)) AS markt_verbrauch_ekn2,
   CAST (CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0
              THEN ((v01.diff_umsatz_netto_konz * v04.kein_zekp_fg * v01.diff_einstandspreis_konz)+ (v01.menge * (1-v04.kein_zekp_fg) * v01.diff_einstandspreis_konz))
              WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1
              THEN ((v01.umsatz_netto * v04.kein_zekp_fg * v01.einstandspreis)+ (v01.menge * (1-v04.kein_zekp_fg) * v01.einstandspreis)) * umrechnungskurs_hist
              ELSE ((v01.umsatz_netto * v04.kein_zekp_fg * v01.einstandspreis)+ (v01.menge * (1-v04.kein_zekp_fg) * v01.einstandspreis))
              END AS DECIMAL(18,4)) AS markt_verbrauch_ekn4
   
   FROM DBP_DATA.ARTBEW_2 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v02
   INNER JOIN DBP_DATA.ART_WUP_EK_ZU_PER_2 v04
   ON  v01.mandant_id  = v04.mandant_id
   AND v01.art_id      = v04.art_id
   AND v01.dat BETWEEN v04.dat_von AND v04.dat_bis
   AND v04.wup_id      = -1
   
   /*INNER JOIN dbp_view.v_kurs_2 v03
   ON  v04.wrg_id     = v03.von_wrg_id
   AND v01.dat BETWEEN v03.dat_von AND v03.dat_bis
   AND v03.kurstyp_id = 9
   AND v03.nach_wrg_id = 'EUR'*/

   WHERE v01.mandant_id <> 1
   --AP0190987/SPEC0225041 Filter E-Loading Artikel_2 / sschuecke 17.11.2023
   AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
   --AP0227085/SPEC0284781 Filter E-Loading Artikel_2 / sschuecke 25.02.2025
   AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
   AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
   AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
   AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
   AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640);