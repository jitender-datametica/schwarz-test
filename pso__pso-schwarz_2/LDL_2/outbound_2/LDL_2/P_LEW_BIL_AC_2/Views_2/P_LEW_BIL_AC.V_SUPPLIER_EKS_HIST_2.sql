CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_supplier_eks_hist_2 (client_id, sup_sid, eks_no_list, eks_no_01, eks_no_02,
eks_no_03, eks_no_04, eks_no_05, eks_no_06, eks_no_07, eks_no_08, eks_no_09, eks_no_10, deleted_fg, dwh_valid_from,
dwh_valid_to, dwh_actual_fg) AS SELECT *
FROM ldl_p_lew_bil.v_supplier_eks_hist_2;