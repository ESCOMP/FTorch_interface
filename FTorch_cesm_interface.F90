module FTorch_cesm_interface
#ifdef USE_FTORCH
  use ftorch,         only: torch_kCPU, torch_tensor, torch_model, torch_tensor_from_array
  use ftorch,         only: torch_model_load, torch_model_forward, torch_delete
#else
  use shr_abort_mod, only : shr_abort_abort
  implicit none
  type :: torch_model
  end type torch_model
  type :: torch_tensor
  end type torch_tensor
  integer, parameter :: torch_kCPU = 0 ! CPU device enum placeholder when FTorch is disabled
  character(len=*), parameter :: message="ERROR: Using FTorch Interface without USE_FTORCH=TRUE"

  interface torch_tensor_from_array
    module procedure torch_tensor_from_array_layout
    module procedure torch_tensor_from_array_nolayout
  end interface torch_tensor_from_array

  interface torch_delete
    module procedure torch_model_delete
    module procedure torch_tensor_delete
    module procedure torch_tensor_array_delete
  end interface torch_delete

contains
  subroutine torch_model_load(model, filename, device_type, device_index, &
                              requires_grad, is_training)
    type(torch_model), intent(out) :: model
    character(len=*), intent(in) :: filename
    integer, intent(in) :: device_type
    integer, optional, intent(in) :: device_index
    logical, optional, intent(in) :: requires_grad
    logical, optional, intent(in) :: is_training
    call shr_abort_abort(message)
  end subroutine torch_model_load

  subroutine torch_tensor_from_array_layout(tensor, data_in, layout, device_type, &
                                            device_index, requires_grad)
    type(torch_tensor), intent(out) :: tensor
    type(*), dimension(..), intent(in) :: data_in
    integer, intent(in) :: layout(:)
    integer, intent(in) :: device_type
    integer, optional, intent(in) :: device_index
    logical, optional, intent(in) :: requires_grad
    call shr_abort_abort(message)
  end subroutine torch_tensor_from_array_layout

  subroutine torch_tensor_from_array_nolayout(tensor, data_in, device_type, &
                                              device_index, requires_grad)
    type(torch_tensor), intent(out) :: tensor
    type(*), dimension(..), intent(in) :: data_in
    integer, intent(in) :: device_type
    integer, optional, intent(in) :: device_index
    logical, optional, intent(in) :: requires_grad
    call shr_abort_abort(message)
  end subroutine torch_tensor_from_array_nolayout

  subroutine torch_model_forward(model, input_tensors, output_tensors, requires_grad)
    type(torch_model), intent(in) :: model
    type(torch_tensor), intent(in) :: input_tensors(:), output_tensors(:)
    logical, optional, intent(in) :: requires_grad
    call shr_abort_abort(message)
  end subroutine torch_model_forward

  subroutine torch_model_delete(model)
    type(torch_model), intent(in) :: model
    call shr_abort_abort(message)
  end subroutine torch_model_delete

  subroutine torch_tensor_delete(tensor)
    type(torch_tensor), intent(inout) :: tensor
    call shr_abort_abort(message)
  end subroutine torch_tensor_delete

  subroutine torch_tensor_array_delete(tensor_array)
    type(torch_tensor), dimension(:), intent(inout) :: tensor_array
    call shr_abort_abort(message)
  end subroutine torch_tensor_array_delete
#endif
end module FTorch_cesm_interface
