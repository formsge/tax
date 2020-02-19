*&---------------------------------------------------------------------*
*&  Include for controller
*&---------------------------------------------------------------------*
class lcl_controller definition.
  public section.
    methods: constructor  importing is_selopts   type ty_selopts.
    methods: process_before_output importing iv_container type ref to cl_gui_custom_container.
    methods: set_gui_status.

  private section.
    data:
      as_selopts  type ty_selopts,
      o_data      type ref to lcl_tc_master_data,
      o_view      type ref to lcl_view.

endclass.

class lcl_controller implementation.
  method constructor.
    as_selopts = is_selopts.
  endmethod.

  method set_gui_status.
    set titlebar  'GUI_TITLE' with text-100.
    set pf-status 'MAIN_STATUS'.
  endmethod.

  method process_before_output.

    data:
      lv_message  type string,
      lt_tc_names type ty_tt_tc_names.

    create object me->o_data
      exporting is_selopts = as_selopts.

    if as_selopts-p_trn = abap_true.
      lt_tc_names = me->o_data->get_names( ).
    elseif as_selopts-p_set = abap_true.

    else.
      " Reserved for future cases
    endif.
*    at_xml_files = me->o_files->select_files( ).
*
*    if lines( at_xml_files ) = 0.
*      lv_message = text-102.
*      message lv_message type 'I' display like 'E'.
*      return.
*    endif.
*
    create object me->o_view
      exporting
        iv_parent = iv_container.

    me->o_view->setup_alv( changing ct_data = lt_tc_names ).
  endmethod.
endclass.
