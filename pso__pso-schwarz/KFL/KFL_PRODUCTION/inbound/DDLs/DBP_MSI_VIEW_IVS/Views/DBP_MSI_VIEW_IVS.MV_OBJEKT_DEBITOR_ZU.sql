CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_OBJEKT_DEBITOR_ZU
      AS
         -- 2009-05-04
         -- Zuordnung Debitor (FI) zu Immo_Objekt
         -- 2009-05-04 Anpassung join/subselect
         -- 2011KW34 mietvertrag_id von 0 auf '0' umgestellt + Basistabelle umgelenkt
         -- 2011KW38 umgestellt auf mietvertrag_flaeche_zu_per, mietvertrag_per, debitor_per da debitor_mietvertrag_zu_per nicht
         -- mehr existiert, weil debitor = konzessionaer
         -- 2011KW49 Ergaenzen Referenz zu Dummyobjekt und nur eine Zuordnung pro Debitor
         -- 2012KW03 Ergaenzen Zuordnung Debitor-Immoobjekt aus FI Daten
         -- 2013-04-11 : Redesign Offene Posten + Mietsicherheiten
         -- 2013-05-03 : UPDATE, anderer Weg fuer DE

         SELECT
         dp.mandant_id,
         dp.debitor_id,
         COALESCE(sub01.immo_objekt_id, 'IW----------0') AS immo_objekt_id
        FROM dbp_view.v_ivs_debitor_per dp
         LEFT JOIN (
         -- KMO aus Mietertrag
         SELECT DISTINCT
         med.mandant_id,
         med.debitor_id,
         med.immo_objekt_id
        FROM dbp_view.v_ivs_mietertrag_detail med
         WHERE med.mandant_id <> 1

         UNION ALL
         -- DE aus Debitor-Immo
         SELECT DISTINCT
         dioz.mandant_id,
         dioz.debitor_id,
         dioz.immo_objekt_id
        FROM dbp_view.v_ivs_debitor_immo_objekt_zu dioz
         WHERE dioz.mandant_id = 1
         ) sub01
         ON sub01.mandant_id = dp.mandant_id
         AND sub01.debitor_id = dp.debitor_id

         WHERE dp.ivs_fg=1
;