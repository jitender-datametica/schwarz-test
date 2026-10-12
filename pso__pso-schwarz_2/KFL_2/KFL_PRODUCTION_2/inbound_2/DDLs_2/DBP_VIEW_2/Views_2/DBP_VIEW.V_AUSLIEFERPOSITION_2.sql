CREATE OR REPLACE VIEW DBP_VIEW.V_AUSLIEFERPOSITION_2 AS 
    SELECT 
        mandant_id
        ,beleg_guid
        ,beleg_pos_guid
        ,belegtyp_id
        ,beleg_id
        ,manuell_erzeugt_fg
        ,beleg_pos_id
        ,tor_id
        ,datzeit_erstellung
        ,datzeit_aenderung
        ,dat_lief_soll
        ,zeit_lief_soll


FROM DBP_DATA.auslieferposition_2 ;