CREATE OR REPLACE VIEW DBP_VIEW.V_ARTBEW_GP_SUM_2 (
   mandant_id                               COMMENT 'Mandant_2'
  ,dat                                      COMMENT 'Datum im Format JJJJ-MM_2-TT'
  ,gp_id                                    COMMENT 'Geschäftspartner - ID (Lieferanten - ID)
'
  ,vw_id                                    COMMENT 'ID des Vertriebswegs. Einkaufs-Sicht auf die wup_2 Objekte
1 = Ost
2 = West
3 = Nord'
  ,wrg_2                                      COMMENT 'Währung, z.Bsp. EUR'
  ,umrechnungskurs_hist                     COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_2 '
  ,umsatz_netto                             COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag'
  ,diff_umsatz_netto_konz                   COMMENT 'von der Konzernwährung abweichender Umsatz netto'
  ,ek_mep                                   COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema)'
  ,diff_ek_mep_konz                         COMMENT 'von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis'
)
COMMENT = 'TP2_AIS - Aggregatstabelle enthält Umsatz und MEP pro Lieferant, Vertriebsweg und Tag_2 - MULTISET'
 AS 
    SELECT 
        mandant_id,
        dat,
        gp_id,
        vw_id,
        wrg_2,
        umrechnungskurs_hist,
        umsatz_netto,
        diff_umsatz_netto_konz,
        ek_mep,
        diff_ek_mep_konz

FROM DBP_DATA.ARTBEW_GP_SUM_2 ;