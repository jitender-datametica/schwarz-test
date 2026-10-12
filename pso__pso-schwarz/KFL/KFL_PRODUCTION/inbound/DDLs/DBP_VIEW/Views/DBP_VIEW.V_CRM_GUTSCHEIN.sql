CREATE OR REPLACE VIEW DBP_VIEW.V_CRM_GUTSCHEIN AS 
    SELECT 
        mandant_id
        ,crm_gutschein_id
        ,crm_vorgang_id
        ,crm_gutschein_grund_id
        ,gutschein_nummer
        ,kostenstelle_id
        ,gutschein_wert
        ,wrg_id


FROM DBP_DATA.crm_gutschein ;