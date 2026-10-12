CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_STOCK_WHAT_IF(
    P_ART_ID            FLOAT,
    P_WUP_ID            FLOAT,
    P_NB_ID             FLOAT,
    P_MANDANT_ID        FLOAT,
    P_DAT_VON           DATE,
    P_DAT_BIS           DATE,
    P_ORDER_PROPOSAL    FLOAT,
    P_ORDER_PROPOSAL_WI FLOAT,
    P_CONFIRM_FG        FLOAT
)
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE 
    dummy FLOAT; 
BEGIN

    DELETE FROM DBP_MSI_DATA.TS_WBS_BESTELLVORSCHLAG_IN_PROMO
    WHERE art_id     = :P_ART_ID
      AND wup_id     = :P_WUP_ID
      AND nb_id      = :P_NB_ID
      AND mandant_id = :P_MANDANT_ID
      AND dat_aktion_von    = :P_DAT_VON
      AND dat_aktion_bis    = :P_DAT_BIS;
      
    INSERT INTO DBP_MSI_DATA.TS_WBS_BESTELLVORSCHLAG_IN_PROMO
        (art_id, wup_id, nb_id, mandant_id, dat_aktion_von, dat_aktion_bis, MENGE_BESTELLVORSCHLAG_IN_PROMO_AME, td_insert, td_update)
    SELECT
        :P_ART_ID,
        :P_WUP_ID,
        :P_NB_ID,
        :P_MANDANT_ID,
        :P_DAT_VON,
        :P_DAT_BIS,
        CASE WHEN :P_CONFIRM_FG = 1 THEN :P_ORDER_PROPOSAL_WI ELSE :P_ORDER_PROPOSAL END,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP;

    COMMIT;
    RETURN 'Artikel gespeichert';

END;
$$;