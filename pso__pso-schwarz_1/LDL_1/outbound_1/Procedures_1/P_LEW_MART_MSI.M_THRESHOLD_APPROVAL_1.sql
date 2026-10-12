CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_threshold_approval (
    CLIENT_ID FLOAT64, 
    APPROVAL_FG FLOAT64, 
    APPROVAL_USER STRING, 
    APPROVAL_RECEIPT_FG FLOAT64, 
    APPROVAL_MANUAL_FG FLOAT64, 
    APPROVAL_CUMULATION_FG FLOAT64, 
    APPROVAL_SCENARIO_FG FLOAT64
)
BEGIN

  BEGIN

    -- ===================================================================
    -- Update receipt threshold table
    -- ===================================================================
    -- Closes opened records with same client_id if there is a new value in with flag -1 in a table.
    EXECUTE IMMEDIATE """
        UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_1 
        SET dat_rec_end = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        WHERE client_id = @CLIENT_ID
        AND dat_rec_end = DATE '9999-12-31'
        AND approval_fg = @APPROVAL_FG
        AND @APPROVAL_RECEIPT_FG = 1
        AND EXISTS (
           SELECT 1
           FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_1
           WHERE client_id = @CLIENT_ID
           AND approval_fg <> 1
           AND @APPROVAL_FG = 1
           AND requesting_user <> @APPROVAL_USER
        )
    """ USING 
        CLIENT_ID AS CLIENT_ID, 
        APPROVAL_FG AS APPROVAL_FG, 
        APPROVAL_RECEIPT_FG AS APPROVAL_RECEIPT_FG, 
        APPROVAL_USER AS APPROVAL_USER;

    -- Opens rows with -1 flag, correct client_id.
    EXECUTE IMMEDIATE """
        UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_1 
        SET dat_rec_start = CURRENT_DATE("Europe/Berlin"),
            approval_fg = CAST(@APPROVAL_FG AS INT64),
            approval_user = @APPROVAL_USER,
            timestamp_approval = CAST(CURRENT_TIMESTAMP() AS DATETIME)
        WHERE client_id = @CLIENT_ID
        AND dat_rec_end = DATE '9999-12-31'
        AND approval_fg <> 1
        AND @APPROVAL_RECEIPT_FG = 1
        AND requesting_user <> @APPROVAL_USER
    """ USING 
        APPROVAL_FG AS APPROVAL_FG, 
        APPROVAL_USER AS APPROVAL_USER, 
        CLIENT_ID AS CLIENT_ID, 
        APPROVAL_RECEIPT_FG AS APPROVAL_RECEIPT_FG;

    -- Deletes all rows that were closed before being in use. Solves if row is updated multiple times per day.
    EXECUTE IMMEDIATE """
        DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_1
        WHERE dat_rec_start > dat_rec_end
    """;

    -- ===================================================================
    -- Update manual threshold table
    -- ===================================================================
    -- Closes opened records with same client_id if there is a new value in with flag -1 in a table.
    EXECUTE IMMEDIATE """
        UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_1 
        SET dat_rec_end = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        WHERE client_id = @CLIENT_ID
        AND dat_rec_end = DATE '9999-12-31'
        AND approval_fg = @APPROVAL_FG
        AND @APPROVAL_MANUAL_FG = 1
        AND EXISTS (
           SELECT 1
           FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_1
           WHERE client_id = @CLIENT_ID
           AND approval_fg <> 1
           AND @APPROVAL_FG = 1
           AND requesting_user <> @APPROVAL_USER
        )
    """ USING 
        CLIENT_ID AS CLIENT_ID, 
        APPROVAL_FG AS APPROVAL_FG, 
        APPROVAL_MANUAL_FG AS APPROVAL_MANUAL_FG, 
        APPROVAL_USER AS APPROVAL_USER;

    -- Opens rows with -1 flag, correct client_id.
    EXECUTE IMMEDIATE """
        UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_1 
        SET dat_rec_start = CURRENT_DATE("Europe/Berlin"),
            approval_fg = CAST(@APPROVAL_FG AS INT64),
            approval_user = @APPROVAL_USER,
            timestamp_approval = CAST(CURRENT_TIMESTAMP() AS DATETIME)
        WHERE client_id = @CLIENT_ID
        AND dat_rec_end = DATE '9999-12-31'
        AND approval_fg <> 1
        AND @APPROVAL_MANUAL_FG = 1
        AND requesting_user <> @APPROVAL_USER
    """ USING 
        APPROVAL_FG AS APPROVAL_FG, 
        APPROVAL_USER AS APPROVAL_USER, 
        CLIENT_ID AS CLIENT_ID, 
        APPROVAL_MANUAL_FG AS APPROVAL_MANUAL_FG;

    -- Deletes all rows that were closed before being in use. Solves if row is updated multiple times per day.
    EXECUTE IMMEDIATE """
        DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_1
        WHERE dat_rec_start > dat_rec_end
    """;

    -- ===================================================================
    -- Update cumulation threshold table
    -- ===================================================================
    -- Closes opened records with same client_id if there is a new value in with flag -1 in a table.
    EXECUTE IMMEDIATE """
        UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_1 
        SET dat_rec_end = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        WHERE client_id = @CLIENT_ID
        AND dat_rec_end = DATE '9999-12-31'
        AND approval_fg = @APPROVAL_FG
        AND @APPROVAL_CUMULATION_FG = 1
        AND EXISTS (
           SELECT 1
           FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_1
           WHERE client_id = @CLIENT_ID
           AND approval_fg <> 1
           AND @APPROVAL_FG = 1
           AND requesting_user <> @APPROVAL_USER
        )
    """ USING 
        CLIENT_ID AS CLIENT_ID, 
        APPROVAL_FG AS APPROVAL_FG, 
        APPROVAL_CUMULATION_FG AS APPROVAL_CUMULATION_FG, 
        APPROVAL_USER AS APPROVAL_USER;

    -- Opens rows with -1 flag, correct client_id.
    EXECUTE IMMEDIATE """
        UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_1 
        SET dat_rec_start = CURRENT_DATE("Europe/Berlin"),
            approval_fg = CAST(@APPROVAL_FG AS INT64),
            approval_user = @APPROVAL_USER,
            timestamp_approval = CAST(CURRENT_TIMESTAMP() AS DATETIME)
        WHERE client_id = @CLIENT_ID
        AND dat_rec_end = DATE '9999-12-31'
        AND approval_fg <> 1
        AND @APPROVAL_CUMULATION_FG = 1
        AND requesting_user <> @APPROVAL_USER
    """ USING 
        APPROVAL_FG AS APPROVAL_FG, 
        APPROVAL_USER AS APPROVAL_USER, 
        CLIENT_ID AS CLIENT_ID, 
        APPROVAL_CUMULATION_FG AS APPROVAL_CUMULATION_FG;

    -- Deletes all rows that were closed before being in use. Solves if row is updated multiple times per day.
    EXECUTE IMMEDIATE """
        DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_1
        WHERE dat_rec_start > dat_rec_end
    """;

    -- ===================================================================
    -- Update scenario threshold table (Attention: threshold_group_id is part of PK)
    -- ===================================================================
    -- Closes opened records with same client_id/threshold_group_id if at least one of the values had changed.
    EXECUTE IMMEDIATE """
        UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
        SET dat_rec_end = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        WHERE client_id = @CLIENT_ID
        AND dat_rec_end = DATE '9999-12-31'
        AND approval_fg = @APPROVAL_FG
        AND @APPROVAL_SCENARIO_FG = 1
        AND EXISTS (
           SELECT 1
           FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 s
           WHERE s.client_id = @CLIENT_ID
           AND s.approval_fg <> 1
           AND @APPROVAL_FG = 1
           AND s.requesting_user <> @APPROVAL_USER
           AND s.threshold_group_id = t_msi_ejr_lp_threshold_scenario.threshold_group_id
        )
    """ USING 
        CLIENT_ID AS CLIENT_ID, 
        APPROVAL_FG AS APPROVAL_FG, 
        APPROVAL_SCENARIO_FG AS APPROVAL_SCENARIO_FG, 
        APPROVAL_USER AS APPROVAL_USER;

    -- Opens rows with -1 flag, correct client_id.
    EXECUTE IMMEDIATE """
        UPDATE p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1 
        SET dat_rec_start = CURRENT_DATE("Europe/Berlin"),
            approval_fg = CAST(@APPROVAL_FG AS INT64),
            approval_user = @APPROVAL_USER,
            timestamp_approval = CAST(CURRENT_TIMESTAMP() AS DATETIME)
        WHERE client_id = @CLIENT_ID
        AND dat_rec_end = DATE '9999-12-31'
        AND approval_fg <> 1
        AND @APPROVAL_SCENARIO_FG = 1
        AND requesting_user <> @APPROVAL_USER
    """ USING 
        APPROVAL_FG AS APPROVAL_FG, 
        APPROVAL_USER AS APPROVAL_USER, 
        CLIENT_ID AS CLIENT_ID, 
        APPROVAL_SCENARIO_FG AS APPROVAL_SCENARIO_FG;

    -- Deletes all rows that were closed before being in use. Solves if row is updated multiple times per day.
    EXECUTE IMMEDIATE """
        DELETE FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario_1
        WHERE dat_rec_start > dat_rec_end
    """;


  EXCEPTION WHEN ERROR THEN
    RAISE USING MESSAGE = 'MESSAGE: ' || @@error.message;
  END;

END;