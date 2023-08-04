tobii :: #library "tobii_interaction_lib_c";


// #include <interaction_lib/api/typedefs.h>

IL_InteractorId :: u64;
IL_MaskId :: u64;
IL_BaseScoreId :: u64;
IL_WeightDistributionId :: u64;
IL_Timestamp :: s64;

IL_EMPTYINTERACTORID         : u64 : 0xfffffffffffffffe;
IL_EMPTYBASESCOREID          : u64 : 0xfffffffffffffffe;
IL_EMPTYWEIGHTDISTRIBUTIONID : u64 : 0xfffffffffffffffe;


// #include <interaction_lib/api/Result.h>

IL_Result :: enum s32 {
    IL_Result_Error_Unknown                       :: -1000;
    IL_Result_Error_StreamTypeNotAvailable        ::  -999;
    IL_Result_Error_NotInTransaction              ::  -998;
    IL_Result_Error_UnknownInteractorId           ::  -997;
    IL_Result_Error_UnknownWeightDistributionId   ::  -996;
    IL_Result_Error_CustomWeightDistributionInUse ::  -995;
    IL_Result_Error_InvalidParamValue             ::  -994;
    IL_Result_Error_NoAdapterSet                  ::  -993;
    IL_Result_Error_AllocationFailed              ::  -992;
    IL_Result_Error_MAX                           ::  -991;

    IL_Result_Ok :: 0;

    IL_Result_Warning_NotInTransaction                              :: 1;
    IL_Result_Warning_AlreadyInTransaction                          :: 2;
    IL_Result_Warning_UnknownInteractorId                           :: 3;
    IL_Result_Warning_UnknownWeightDistributionId                   :: 4;
    IL_Result_Warning_InsufficientInformationForCoordinateTransform :: 5;
    IL_Result_Warning_NoAdapterSet                                  :: 6;
    IL_Result_Warning_NoDeviceAvailable                             :: 7;
    IL_Result_Warning_Timeout                                       :: 8;
    IL_Result_Warning_MAX                                           :: 9;
}


// #include <interaction_lib/api/Logger.h>

IL_Logger_Callback :: #type(level: IL_LoggingLevel, text: *u8, ctx: *void) -> void #c_call;
// @TODO document this on wiki

/// A structure with information about a callback function that will be called by the Interaction Library
/// for logging purposes.
IL_Logger :: struct {
    /// The callback function that is called when a log entry is available.
    callback :: IL_Logger_Callback;

    // The highest log level at which the callback function will be called.
    level :: IL_LoggingLevel;

    /// The ctx that is passed to the callback function.
    ctx: *void;
}

IL_LoggingLevel :: enum s32 {
    IL_LoggingLevel_Error;
    IL_LoggingLevel_Warn;
    IL_LoggingLevel_Info;
    IL_LoggingLevel_Debug;
    IL_LoggingLevel_Trace;
}


// #include <interaction_lib/api/Adapter.h>

ILAdapter_BeginTransactionCallback :: #type(ctx: *void) -> void #c_call;

ILAdapter_CommitTransactionCallback :: #type(ctx: *void) -> void #c_call;
ILAdapter_GetStreamTypesProvidedCallback :: #type(input_type: *IL_StreamInputType, count: u32, ctx: *void) -> void #c_call;
ILAdapter_GetStreamCoordinateTransformInfoCallback :: #type(transform_info : *IL_StreamCoordinateTransformInfo, count: u32, ctx: *void) -> void #c_call;

ILAdapter_PostGazePointDataCallback :: #type(data: *IL_GazePointData, ctx: *void) -> void #c_call;
ILAdapter_PostGazeOriginDataCallback :: #type(data: *IL_GazeOriginData, ctx: *void) -> void #c_call;
ILAdapter_PostPresenceDataCallback :: #type(data: *IL_PresenceData, ctx: *void) -> void #c_call;
ILAdapter_PostHeadPoseDataCallback :: #type(data: *IL_HeadPoseData, ctx: *void) -> void #c_call;
ILAdapter_PostResponsiveGazePointDataCallback :: #type(data: *IL_ResponsiveGazePointData, ctx: *void) -> void #c_call;

ILAdapter_TrackingStatusCallback :: #type(status: IL_TrackingStatus, ctx: *void) -> void #c_call;
ILAdapter_DeviceNotificationCallback :: #type(notification: IL_DeviceNotification, ctx: *void) -> void #c_call;

ILAdapter_LoggingCallback :: #type(level: IL_LoggingLevel, message: *u8, tag1: *u8, tag2: *u8, formattedMetadata: *u8, ctx: *void) -> void #c_call;
ILAdapter_ForwardLoggingStatementCallback :: #type(level: IL_LoggingLevel, forwardedLoggingStatement: *u8, ctx: *void) -> void #c_call;

/// @name Functions Called by InteractionLib
///
/// Typedefs for pointers to functions that the Interaction Library will call.
/// They must be implemented in the adapter.

/// Pointer to an adapter-specific implementation detail context.
ILAdapter_AdapterContext :: *void;

/// Lightweight creation/instantiation of the adapter should happen on this call. All heavy, I/O or IPC operations
/// should be done on ILAdapter_StartAdapter.
///
/// @param createDestroyContext  When Interaction Library calls #ILAdapter_CreateAdapter this parameter will be set
///                              to whatever is in the originally passed IL_AdapterFunctions.createDestroyContext.
/// @param context[out]          Before calling #ILAdapter_CreateAdapter, the caller must set the value pointed
///                              at by the parameter @p context to @c nullptr. The adapter implementation should
///                              set the out parameter @p context (dereferenced) and return true on success.
/// @return                      true on success, otherwise false.
ILAdapter_CreateAdapter :: #type(createDestroyContext: *void, ctx: *ILAdapter_AdapterContext) -> bool #c_call;

/// Lightweight destroy of the adapter should happen on this call. All heavy, I/O or IPC operations
/// needed to destroy the adapter should be done on ILAdapter_StopAdapter.
///
/// @param createDestroyContext  When Interaction Library calls #ILAdapter_DestroyAdapter this parameter will be set
///                              to whatever is in the originally passed IL_AdapterFunctions.createDestroyContext.
/// @param context[in,out]       The adapter implementation should set the out parameter @p context (dereferenced)
///                              to @c nullptr after destroying the adapter.
ILAdapter_DestroyAdapter :: #type(createDestroyContext: *void, ctx: *ILAdapter_AdapterContext) -> void #c_call;

/// The adapter implementation should generate IL_TrackingStatus_Ok on #ILAdapter_TrackingStatusCallback when invoked.
///
/// @param fieldOfUse  Will be the value that was used when the Interaction Library was created.
ILAdapter_StartAdapter :: #type(adaptor_ctx: ILAdapter_AdapterContext, fieldOfUse: IL_FieldOfUse) -> void #c_call;

/// The adapter implementation should generate IL_TrackingStatus_NotAvailable on #ILAdapter_TrackingStatusCallback when invoked.
ILAdapter_StopAdapter :: #type(adaptor_ctx: ILAdapter_AdapterContext) -> void #c_call;

/// The adapter implementation should here generate calls for gaze point data, gaze origin data, etc., on registered callbacks.
/// Expected to be consistent with what is reported by #ILAdapter_GetStreamTypesProvided and #ILAdapter_GetStreamTypesProvidedCallback.
ILAdapter_UpdateAdapter :: #type(adaptor_ctx: ILAdapter_AdapterContext) -> void #c_call;

/// The adapter implementation should block until a device connection is available.
ILAdapter_WaitForDeviceConnection :: #type(adaptor_ctx: ILAdapter_AdapterContext) -> bool #c_call;

/// The adapter implementation should block until any streaming data is available.
ILAdapter_WaitForStreamingDataAvailable :: #type(adaptor_ctx: ILAdapter_AdapterContext) -> bool #c_call;

/// The adapter implementation should invoke #ILAdapter_GetStreamTypesProvidedCallback.
ILAdapter_GetStreamTypesProvided :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_GetStreamTypesProvidedCallback, ctx: *void) -> void #c_call;

/// The adapter implementation should invoke #ILAdapter_GetStreamCoordinateTransformInfoCallback.
/// The IL_StreamCoordinateTransformInfo struct and its contents will be copied at the receiving end when the
/// ILAdapter_GetStreamCoordinateTransformInfoCallback callback is invoked and does not need to be kept alive afterwards.
ILAdapter_GetStreamCoordinateTransformInfo :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_GetStreamCoordinateTransformInfoCallback, ctx: *void) -> void #c_call;


/// @name Callback Registration Functions Called by InteractionLib
///
/// Typedefs for pointers to callback registration functions that the Interaction Library will call.
/// The adapter implementation should call the registered callbacks in its #ILAdapter_UpdateAdapter function.
///
/// All invocations of stream callbacks are expected to be surrounded by calls to #ILAdapter_BeginTransactionCallback and
/// #ILAdapter_CommitTransactionCallback in #ILAdapter_UpdateAdapter.

ILAdapter_RegisterBeginTransactionCallback :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_BeginTransactionCallback, ctx: *void) -> void #c_call;
ILAdapter_RegisterCommitTransactionCallback :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_BeginTransactionCallback, ctx: *void) -> void #c_call;
ILAdapter_RegisterPostGazePointDataCallback :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_PostGazePointDataCallback, ctx: *void) -> bool #c_call;
ILAdapter_RegisterPostGazeOriginDataCallback :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_PostGazeOriginDataCallback, ctx: *void) -> bool #c_call;
ILAdapter_RegisterPostPresenceDataCallback :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_PostPresenceDataCallback, ctx: *void) -> bool #c_call;
ILAdapter_RegisterPostHeadPoseDataCallback :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_PostHeadPoseDataCallback, ctx: *void) -> bool #c_call;
ILAdapter_RegisterPostResponsiveGazePointDataCallback :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_PostResponsiveGazePointDataCallback, ctx: *void) -> bool #c_call;

/// #ILAdapter_TrackingStatusCallback is expected to be invoked by (at least) #ILAdapter_StartAdapter and #ILAdapter_StopAdapter.
ILAdapter_RegisterTrackingStatusCallback :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_TrackingStatusCallback, ctx: *void) -> bool #c_call;

ILAdapter_RegisterDeviceNotificationCallback :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_DeviceNotificationCallback, ctx: *void) -> bool #c_call;

ILAdapter_RegisterLoggingCallback :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_LoggingCallback, ctx: *void) -> bool #c_call;
ILAdapter_RegisterForwardLoggingStatementCallback :: #type(adaptor_ctx: ILAdapter_AdapterContext, callback: ILAdapter_ForwardLoggingStatementCallback, ctx: *void) -> bool #c_call;


IL_AdapterFunctions :: struct {
    createDestroyContext : *void;

    createAdapter :: ILAdapter_CreateAdapter;
    destroyAdapter :: ILAdapter_DestroyAdapter;

    startAdapter :: ILAdapter_StartAdapter;
    stopAdapter :: ILAdapter_StopAdapter;
    updateAdapter :: ILAdapter_UpdateAdapter;

    waitForDeviceConnection :: ILAdapter_WaitForDeviceConnection;
    waitForStreamingDataAvailable :: ILAdapter_WaitForStreamingDataAvailable;
    getStreamTypesProvided :: ILAdapter_GetStreamTypesProvided;
    getStreamCoordinateTransformInfo :: ILAdapter_GetStreamCoordinateTransformInfo;

    registerBeginTransactionCallback :: ILAdapter_RegisterBeginTransactionCallback;
    registerCommitTransactionCallback :: ILAdapter_RegisterCommitTransactionCallback;

    registerPostGazePointDataCallback :: ILAdapter_RegisterPostGazePointDataCallback;
    registerPostGazeOriginDataCallback :: ILAdapter_RegisterPostGazeOriginDataCallback;
    registerPostPresenceDataCallback :: ILAdapter_RegisterPostPresenceDataCallback;
    registerPostHeadPoseDataCallback :: ILAdapter_RegisterPostHeadPoseDataCallback;
    registerPostResponsiveGazePointDataCallback :: ILAdapter_RegisterPostResponsiveGazePointDataCallback;

    registerTrackingStatusCallback :: ILAdapter_RegisterTrackingStatusCallback;
    registerDeviceNotificationCallback :: ILAdapter_RegisterDeviceNotificationCallback;

    registerLoggingCallback :: ILAdapter_RegisterLoggingCallback;
    registerForwardLoggingStatementCallback :: ILAdapter_RegisterForwardLoggingStatementCallback;
}


// #include <interaction_lib/datatypes/DeviceNotification.h>

IL_DeviceNotification :: enum s32 {
    IL_DeviceNotification_None                    :: 0;
    IL_DeviceNotification_UpdatedStreamsAvailable :: 1;
    IL_DeviceNotification_UpdatedConfig           :: 2;
}


// #include <interaction_lib/datatypes/StreamCoordinateTransformInfo.h>

IL_StreamCoordinateTransformInfo :: struct {
    streamType              : IL_StreamInputType;
    unitsPerMm_xy           : [2] float32;
    rangeUnits_xy           : [2] float32;
    offsetUnits_xy          : [2] float32;
    coordinateSystemType    : IL_StreamCoordinateSystemType;
    displayAreaId           : *u8;
    usesAbsoluteCoordinates : bool;
}


// #include <interaction_lib/datatypes/StreamCoordinateSystemType.h>

IL_StreamCoordinateSystemType :: enum s32 {
    IL_StreamCoordinateSystemType_TopLeftLeftHanded;
    IL_StreamCoordinateSystemType_TopLeftRightHanded;
    IL_StreamCoordinateSystemType_CenteredRightHanded;
    IL_StreamCoordinateSystemType_CenteredLeftHanded;
}


// #include <interaction_lib/datatypes/FieldOfUse.h>

IL_FieldOfUse :: enum s32 {
    IL_FieldOfUse_Interactive :: 1;
    IL_FieldOfUse_Analytical  :: 2;
}


// #include <interaction_lib/datatypes/WeightDistributionData.h>

IL_WeightDistributionType :: enum s32 {
    IL_WeightDistributionType_Flat                    :: 0;        // default, means no standard weight distribution is applied
    IL_WeightDistributionType_CenterWeighted          :: 1;        // center weighted
    IL_WeightDistributionType_LeftWeighted            :: 2;        // NOT IMPLEMENTED YET, please do not use
    IL_WeightDistributionType_RightWeighted           :: 4;        // NOT IMPLEMENTED YET, please do not use
    IL_WeightDistributionType_TopWeighted             :: 8;        // NOT IMPLEMENTED YET, please do not use
    IL_WeightDistributionType_BottomWeighted          :: 16;       // NOT IMPLEMENTED YET, please do not use
    IL_WeightDistributionType_TopLeftWeighted         :: 32;       // NOT IMPLEMENTED YET, please do not use
    IL_WeightDistributionType_TopRightWeighted        :: 64;       // NOT IMPLEMENTED YET, please do not use
    IL_WeightDistributionType_BottomLeftWeighted      :: 128;      // NOT IMPLEMENTED YET, please do not use
    IL_WeightDistributionType_BottomRightWeighted     :: 256;      // NOT IMPLEMENTED YET, please do not use
    IL_WeightDistributionType_HorizontalLineWeighted  :: 512;      // NOT IMPLEMENTED YET, please do not use
    IL_WeightDistributionType_VerticalLineWeighted    :: 1024;     // NOT IMPLEMENTED YET, please do not use
    IL_WeightDistributionType_Occluder                :: 16384;    // means this interactor blocks other interactors behind it
    IL_WeightDistributionType_LastFlag                :: 32768;    // INTERNAL from here,  please do not use any of the following values
    IL_WeightDistributionType_CustomBitmapWeighted    :: 32769;
    IL_WeightDistributionType_EllipsoidOutline        :: 32770;
    IL_WeightDistributionType_CustomFunction          :: 32771;
}


// #include <interaction_lib/math/Rectangle.h>

IL_Rectangle :: struct {
    x, y, w, h : float32;
}


// #include <interaction_lib/datatypes/Validity.h>

IL_Validity :: enum s32 {
    IL_Validity_Invalid;
    IL_Validity_Valid;
}


// #include <interaction_lib/datatypes/PresenceData.h>


IL_Presence :: enum s32 {
    IL_Presence_Unknown;
    IL_Presence_Away;
    IL_Presence_Present;
}

IL_PresenceData :: struct {
    timestamp_us : IL_Timestamp;
    presence     : IL_Presence;
}


// #include <interaction_lib/datatypes/StreamInputType.h>


IL_StreamInputType :: enum s32 {
    IL_StreamInputType_GazePointData;
    IL_StreamInputType_GazeOriginData;
    IL_StreamInputType_PresenceData;
    IL_StreamInputType_HeadPoseData;
    IL_StreamInputType_ResponsiveGazePointData;

    IL_StreamInputType_Count;
}


// #include <interaction_lib/datatypes/TrackingStatus.h>


IL_TrackingStatus :: enum s32 {
    IL_TrackingStatus_Ok           :: 0;
    IL_TrackingStatus_NotAvailable :: 65535;
}


// #include <interaction_lib/datatypes/InteractionEventTypes.h>

IL_GazeFocusEvent :: struct {
    timestamp_us : IL_Timestamp;
    id           : IL_InteractorId;
    hasFocus     : bool;
}

IL_GazeFocusEventCallback :: #type(event: IL_GazeFocusEvent, ctx: *void) -> void #c_call;


// #include <interaction_lib/datatypes/GazePointData.h>

IL_GazePointData :: struct {
    timestamp_us : IL_Timestamp;
    validity     : IL_Validity;
    x, y         : float32;
    #place x;
    xy : Vector2;
}


// #include <interaction_lib/datatypes/GazeOriginData.h>


IL_GazeOriginData :: struct {
    timestamp_us  : IL_Timestamp;
    leftValidity  : IL_Validity;
    left_xyz      : [3] float32;
    rightValidity : IL_Validity;
    right_xyz     : [3] float32;
}


// #include <interaction_lib/datatypes/HeadPoseData.h>

IL_HeadPoseData :: struct {
    timestamp_us          : IL_Timestamp;
    position_validity     : IL_Validity;
    position_xyz          : [3] float32;
    rotation_validity_xyz : [3] IL_Validity;
    rotation_xyz          : [3] float32;
}


// #include <interaction_lib/datatypes/ResponsiveGazePointData.h>

IL_ResponsiveGazePointData :: struct {
    timestamp_us : IL_Timestamp;
    validity     : IL_Validity ;
    x, y         : float32;
}


// #include <interaction_lib/datatypes/StreamingDataEventTypes.h>


IL_GazePointDataCallback :: #type(data: IL_GazePointData, ctx: *void) -> void #c_call;
IL_GazeOriginDataCallback :: #type(data: IL_GazeOriginData, ctx: *void) -> void #c_call;
IL_PresenceDataCallback :: #type(data: IL_PresenceData, ctx: *void) -> void #c_call;
IL_HeadPoseDataCallback :: #type(data: IL_HeadPoseData, ctx: *void) -> void #c_call;
IL_ResponsiveGazePointDataCallback :: #type(data: IL_ResponsiveGazePointData, ctx: *void) -> void #c_call;
IL_DataStreamCapabilitiesChangedCallback :: #type(ctx: *void) -> void #c_call;


// #include <interaction_lib/datatypes/Capability.h>

IL_Capability :: enum s32 {
    IL_Capability_Unknown;
    IL_Capability_Unavailable;
    IL_Capability_Available;
    IL_Capability_Enabled;

    IL_Capability_Count;
}


// #include <interaction_lib/datatypes/StreamType.h>


IL_StreamType :: enum s32 {
    IL_StreamType_GazePointData;
    IL_StreamType_GazeOriginData;
    IL_StreamType_PresenceData;
    IL_StreamType_HeadPoseData;
    IL_StreamType_ResponsiveGazePointData;
}


/// A "handle" type that identifies an actual underlying Interaction Library implementation instance.
IL_Context :: struct {
    /// Internal to the Interaction Library C binding implementation.
    int_lib : *void;
}


/// Creates an Interaction Library instance with a default adapter, if available.
///
/// @see         IL_SetAdapter()
/// @param       fieldOfUse  This mandatory flag denotes if the Interaction Library is used for interactive or
///                          analytical purposes. Please see the EULA and documentation for more information.
/// @param[out]  ctx     Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return                  IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_CreateInteractionLib :: (ctx: **IL_Context, fieldOfUse: IL_FieldOfUse) -> IL_Result #foreign tobii;


/// Creates an Interaction Library instance with a default adapter, if available.
///
/// @see         IL_SetAdapter()
/// @param       fieldOfUse  This mandatory flag denotes if the Interaction Library is used for interactive or
///                          analytical purposes. Please see the EULA and documentation for more information.
/// @param       logger      Optional pointer to a structure with information about a callback function
///                          that will be called by the Interaction Library for logging purposes.
///                          If @p logger is @c NULL, the Interaction Library does no logging related processing.
///                          The callback function is set in the @c callback field of the @IL_Logger structure.
///                          The @p level parameter denotes the highest log level at which the callback function will be called.
///                          For example, if "info" is specified, then the callback will be called for "error", "warning" and "info",
///                          but not for "debug" and "trace".
///                          The @p text parameter passed to the callback function points at a null terminated character array
///                          formatted in a format specified by Tobii. The parameter is only valid in the scope of the callback.
///                          The @p ctx parameter passed to the callback function is set in the @c ctx field of the @IL_Logger structure.
/// @param[out]  ctx     Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return                  IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_CreateInteractionLibWithLogger :: (ctx: **IL_Context, fieldOfUse: IL_FieldOfUse, logger: *IL_Logger) -> IL_Result #foreign tobii;


/// Creates an Interaction Library instance with a custom adapter.
///
/// @see         IL_SetAdapter()
/// @param       fieldOfUse        This mandatory flag denotes if the Interaction Library is used for interactive or
///                                analytical purposes. Please see the EULA and documentation for more information.
/// @param       logger            Optional pointer to a structure with information about a callback function
///                                that will be called by the Interaction Library for logging purposes.
///                                If @p logger is @c NULL, the Interaction Library does no logging related processing.
///                                The callback function is set in the @c callback field of the @IL_Logger structure.
///                                The @p level parameter denotes the highest log level at which the callback function will be called.
///                                For example, if "info" is specified, then the callback will be called for "error", "warning" and "info",
///                                but not for "debug" and "trace".
///                                The @p text parameter passed to the callback function points at a null terminated character array
///                                formatted in a format specified by Tobii. The parameter is only valid in the scope of the callback.
///                                The @p ctx parameter passed to the callback function is set in the @c ctx field of the @IL_Logger structure.
/// @param       adapterFunctions  Pointer to an IL_AdapterFunctions structure defining the custom adapter.
///                                @c NULL is a valid parameter value which means the default adapter will not be set.
///                                Without a valid adapter the following functions will do nothing and return Result_Warning_NoAdapterSet:
///                                will return IL_Result_Error_NoAdapterSet: IL_Update(), IL_UpdateStreamingDataOutput(),
///                                IL_UpdateInteraction(), IL_SubscribeGazePointData(), IL_SubscribeGazeOriginData(),
///                                IL_SubscribePresenceData(), and IL_SubscribeHeadPoseData(). However, it is still possible to
///                                add interactors and subscribe to gaze focus events.
/// @param[out]  ctx           Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return                        IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_CreateInteractionLibWithAdapter :: (ctx: **IL_Context, fieldOfUse: IL_FieldOfUse, logger: *IL_Logger, adapterFunctions: *IL_AdapterFunctions) -> IL_Result #foreign tobii;

/// Destroys an Interaction Library instance.
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_DestroyInteractionLib :: (ctx: *IL_Context) -> IL_Result #foreign tobii;

/// Sets a custom adapter, or resets the current adapter.
///
/// @param  ctx           Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  adapterFunctions  Pointer to an IL_AdapterFunctions structure defining the custom adapter.
///                           @c NULL is a valid parameter value, with will cause the current adapter to be removed.
///                           Without a valid adapter the following functions will do nothing and return Result_Warning_NoAdapterSet:
///                           will return IL_Result_Error_NoAdapterSet: IL_Update(), IL_UpdateStreamingDataOutput(),
///                           IL_UpdateInteraction(), IL_SubscribeGazePointData(), IL_SubscribeGazeOriginData(),
///                           IL_SubscribePresenceData(), and IL_SubscribeHeadPoseData(). However, it is still possible to
///                           add interactors and subscribe to gaze focus events.
/// @return                   IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_SetAdapter :: (ctx: *IL_Context, adapterFunctions: *IL_AdapterFunctions) -> IL_Result #foreign tobii;


/// Adds a display area (usually a screen) to the coordinate transform setup.
/// Typically call this method multiple times to add information on dpi scaling and location of all screens in the
/// system (see sample/separate documention for details).
///
/// If you are in a single screen environment, or a defacto single screen environment (see above), or use other
/// (external) mechanisms to handle multiple displays areas, you may call this only once and then omit (set to zero/null) all
/// parameters except the first two.
///
/// If you are unable to determine this information in your environment, please use
/// CoordinateTransformSetDisplayDensity() instead (see below).
///
/// @note If you are using a UI binding, it will usually take care of setting up all display areas.
///
/// @param  ctx               Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  widthUserUnits        The width  in your preferred units (eg. with dpi scaling in your environment, or other preferred units)
/// @param  heightUserUnits       The height in your preferred units (eg. with dpi scaling in your environment, or other preferred units)
/// @param  widthVirtualUnits     The width  in system virtual screen units (or custom units that you use for system display setup)
/// @param  heightVirtualUnits    The height in system virtual screen units (or custom units that you use for system display setup)
/// @param  xOriginVirtualUnits   The display origin x coordinate in the system virtual screen coordinate system (or your custom space for system display setup)
/// @param  yOriginVirtualUnits   The display origin y coordinate in the system virtual screen coordinate system (or your custom space for system display setup)
/// @param  virtualDisplayAreaId  The virtual display id as a null terminated string (eg. on Windows this is a number)
/// @return                       IL_Result_Ok if the operation succeeded; otherwise an IL_Result warning or error code.
IL_CoordinateTransformAddOrUpdateDisplayArea :: (ctx: *IL_Context,
                                                widthUserUnits: float32, heightUserUnits: float32,
                                                widthVirtualUnits: float32, heightVirtualUnits: float32,
                                                xOriginVirtualUnits: float32, yOriginVirtualUnits: float32,
                                                virtualDisplayAreaId: *u8)
                                                -> IL_Result #foreign tobii;

/// Sets your origin position, as it is in the virtual coordinate system.
/// Typically used to set the window position to use window local coordinates for streams and interactors,
/// or one could set the display center to use a centered, left-handed coordinate system.
///
/// @note This command is optional. Not setting this will assume system virtual screen coordinates are being used for
/// all on-display coordinates (or the custom coordinate system units that you used for system display setup).
///
/// @param  ctx                    Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  xOriginOffsetVirtualUnits  The x offset in the system virtual screen coordinate system (or your custom space)
/// @param  yOriginOffsetVirtualUnits  The y offset in the system virtual screen coordinate system (or your custom space)
/// @return                            IL_Result_Ok if the operation succeeded; otherwise an IL_Result warning or error code.
IL_CoordinateTransformSetOriginOffset :: (ctx: *IL_Context, xOriginOffsetVirtualUnits: float32, yOriginOffsetVirtualUnits: float32) -> IL_Result #foreign tobii;


/// An alternative to IL_CoordinateTransformAddOrUpdateDisplayArea(), normally only used in special circumstances.
///
/// This method exists as an alternative or addition to IL_CoordinateTransformAddOrUpdateDisplayArea(). It is mainly
/// intended to be used in edge cases where you are in a sandboxed environment and cannot access information about
/// displays, or if a specialized adapter is used that you cannot access or modify for some reason and
/// IL_CoordinateTransformAddOrUpdateDisplayArea() is insufficient to solve the dpi scaling problem. You can see if you
/// need to use IL_CoordinateTransformSetDisplayDensity() by checking the return value from
/// IL_CoordinateTransformAddOrUpdateDisplayArea(). In almost all situations, using only
/// IL_CoordinateTransformAddOrUpdateDisplayArea() is sufficient.
///
/// @note Only to be used in special circumstances!
///
/// @param  ctx      Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  xUnitsPerMm  The number of horizontal units per mm.
/// @param  yUnitsPerMm  The number of vertical units per mm.
/// @return              IL_Result_Ok if the operation succeeded; otherwise an IL_Result warning or error code.
IL_CoordinateTransformSetDisplayDensity :: (ctx: *IL_Context, xUnitsPerMm: float32, yUnitsPerMm: float32) -> IL_Result #foreign tobii;



/// Begins an interactor update transaction, in which many add/update/remove/clear calls are batched.
///
/// @note            Must be called before any add/update/remove/clear calls.
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_BeginInteractorUpdates :: (ctx: *IL_Context) -> IL_Result #foreign tobii;

/// Commits all batched interactor add/update/remove/clear calls done since IL_BeginInteractorUpdates() was called.
///
/// @note            Must be called for any interactor or interactor weights modifications to have effect.
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_CommitInteractorUpdates :: (ctx: *IL_Context) -> IL_Result #foreign tobii;

/// Adds an interactor or updates an existing one, specifying its @p bounds and @p z value (the value increases towards the user).
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  id
/// @param  bounds
/// @param  z
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_AddOrUpdateInteractor :: (ctx: *IL_Context, id: IL_InteractorId, bounds: IL_Rectangle, z: float32) -> IL_Result #foreign tobii;

/// Updates the @p bounds for an existing interactor.
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  id
/// @param  bounds
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_UpdateInteractorBounds :: (ctx: IL_Context, id: IL_InteractorId, bounds: IL_Rectangle) -> IL_Result #foreign tobii;

/// Updates the @p z value for an existing interactor (the value increases towards the user).
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  id
/// @param  z
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_UpdateInteractorZ :: (ctx: *IL_Context, id: IL_InteractorId, z: float32) -> IL_Result #foreign tobii;

/// Removes an existing interactor and all its related data.
///
/// @note            Custom weight distribution bitmaps are not removed, since they may be shared between interactors.
///                  However, the *binding* between the interactor and the custom weight distribution bitmaps are removed.
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  id
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_RemoveInteractor :: (ctx: *IL_Context, id: IL_InteractorId) -> IL_Result #foreign tobii;

/// Removes all existing interactors.
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_ClearInteractors :: (ctx: *IL_Context) -> IL_Result #foreign tobii;

/// Sets the built-in standard weight distribution of an interactor, e.g., center weighted or flat.
///
/// @param  ctx                  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  id
/// @param  weightDistributionTypes
/// @return                          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_UpdateInteractorStandardWeightDistributionTypes :: (ctx: *IL_Context, id: IL_InteractorId, weightDistributionTypes: IL_WeightDistributionType) -> IL_Result #foreign tobii;

/// Adds a new custom weight distribution bitmap or updates an existing one.
///
/// @param  ctx               Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  weightDistributionId
/// @param  isWeightDistribution
/// @param  isStencilMap
/// @param  bitmapColumns
/// @param  bitmapRows
/// @param  bitmap
/// @return                       IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_AddOrUpdateCustomWeightDistributionBitmap :: (ctx: *IL_Context, weightDistributionId: IL_WeightDistributionId, isWeightDistribution: bool, isStencilMap: bool, bitmapColumns: s32, bitmapRows: s32, bitmap: *u8) -> IL_Result #foreign tobii;
// @TODO might be `s64` instead

/// Removes an existing custom weight distribution bitmap.
///
/// @param  ctx               Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  weightDistributionId
/// @return                       IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_RemoveCustomWeightDistributionBitmap :: (ctx: *IL_Context, weightDistributionId: IL_WeightDistributionId) -> IL_Result #foreign tobii;

/// Adds a new custom weight distribution bitmap and binds it to an existing interactor, or changes an existing binding.
///
/// @param  ctx               Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  id
/// @param  weightDistributionId
/// @return                       IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_AddOrUpdateBindingToCustomWeightDistribution :: (ctx: *IL_Context, id: IL_InteractorId, weightDistributionId: IL_WeightDistributionId) -> IL_Result #foreign tobii;

/// Removes an existing binding to a custom weight distribution bitmap for the specified interactor.
///
/// @param  ctx               Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  id
/// @param  weightDistributionId
/// @return                       IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_RemoveBindingToCustomWeightDistribution :: (ctx: *IL_Context, id: IL_InteractorId, weightDistributionId: IL_WeightDistributionId) -> IL_Result #foreign tobii;



/// Subscribes to interactor gaze focus events.
///
/// @param  ctx          Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  callback
/// @param  callbackctx  Will be passed to the callback when the callback is invoked.
/// @return                  IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_SubscribeGazeFocusEvents :: (ctx: *IL_Context, callback: IL_GazeFocusEventCallback, callbackctx: *void) -> IL_Result #foreign tobii;

/// Unsubscribes from interactor gaze focus events.
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_UnsubscribeGazeFocusEvents :: (ctx: *IL_Context) -> IL_Result #foreign tobii;



/// Subscribes to gaze point data.
///
/// @param  ctx          Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  callback
/// @param  callbackctx  Will be passed to the callback when the callback is invoked.
/// @return                  IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_SubscribeGazePointData :: (ctx: *IL_Context, callback: IL_GazePointDataCallback, callbackctx: *void) -> IL_Result #foreign tobii;

/// Subscribes to gaze origin data.
///
/// @param  ctx          Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  callback
/// @param  callbackctx  Will be passed to the callback when the callback is invoked.
/// @return                  IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_SubscribeGazeOriginData :: (ctx: *IL_Context, callback: IL_GazeOriginDataCallback, callbackctx: *void) -> IL_Result #foreign tobii;

/// Subscribes to presence data.
///
/// @param  ctx          Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  callback
/// @param  callbackctx  Will be passed to the callback when the callback is invoked.
/// @return                  IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_SubscribePresenceData :: (ctx: *IL_Context, callback: IL_PresenceDataCallback, callbackctx: *void) -> IL_Result #foreign tobii;

/// Subscribes to head pose data.
///
/// @param  ctx          Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  callback
/// @param  callbackctx  Will be passed to the callback when the callback is invoked.
/// @return                  IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_SubscribeHeadPoseData :: (ctx: *IL_Context, callback: IL_HeadPoseDataCallback, callbackctx: *void) -> IL_Result #foreign tobii;

/// Unsubscribes from gaze point data.
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_UnsubscribeGazePointData :: (ctx: *IL_Context) -> IL_Result #foreign tobii;

/// Unsubscribes from gaze origin data.
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_UnsubscribeGazeOriginData :: (ctx: *IL_Context) -> IL_Result #foreign tobii;

/// Unsubscribes from presence data.
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_UnsubscribePresenceData :: (ctx: *IL_Context) -> IL_Result #foreign tobii;

/// Unsubscribes from head pose data.
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_UnsubscribeHeadPoseData :: (ctx: *IL_Context) -> IL_Result #foreign tobii;



/// Get information on the current system capabilities for a data stream.
///
/// Data stream availability is dependent on if a device is present, what type of device it is and current system state
/// of the device being used. Data streams are typically not enabled unless the they are subscribed to, either internally
/// by the Interaction Library or from this api.
///
/// @param  ctx         Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  streamType      The stream type to get capability information on.
/// @param[out] capability  Will be set to the system capability for the stream type.
/// @return                 IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_GetDataStreamCapability :: (ctx: *IL_Context, streamType: IL_StreamType, capability: *IL_Capability) -> IL_Result #foreign tobii;

/// This callback will be triggered on IL_UpdateStreamingDataOutput()/IL_Update()/IL_WaitAndUpdate() if capabilities have changed.
/// Querying capabilites with GetDataStreamCapability(...) on this callback is allowed.
///
/// @param  ctx          Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @param  callback
/// @param  callbackctx  Will be passed to the callback when the callback is invoked.
/// @return                  IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_SubscribeDataStreamCapabilitiesChanged :: (ctx: *IL_Context, callback: IL_DataStreamCapabilitiesChangedCallback, callbackctx: *void) -> IL_Result #foreign tobii;

/// Unsubscribes from data stream capabilities changed notifications.
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return          IL_Result_Ok If successful; otherwise another IL_Result warning or error code.
IL_UnsubscribeDataStreamCapabilitiesChanged :: (ctx: *IL_Context) -> IL_Result #foreign tobii;



/// Checks/waits for device connection, waits for data, and updates.
///
/// This is a *convenience method* that aggregates all necessary control methods into one, and sleeps the calling thread for
/// the appropriate amount of time between connection attempts when no device is connected. The recommended connection attempt
/// interval is one second, passing 0 means no sleep.
///
/// If you need granular control over updates and/or non-blocking calls use a suitable combination of the various other control methods.
///
/// @return IL_Result_Ok if all goes well. See the other control methods for information about other possible return codes.
IL_WaitAndUpdate :: (ctx: *IL_Context, connectionIntervalMs: u64) -> IL_Result #foreign tobii;

/// Waits for a device to be available and a connection to be established.
///
/// @return IL_Result_Warning_NoDeviceAvailable  if a device can't be connected to (wait time is short but varies with adapter).
/// @return IL_Result_Ok                         if a device is connected to. When a device connection has already been made
///                                              previously and is still available, it returns IL_Result_Ok immediately.
IL_WaitForDeviceConnection :: (ctx: *IL_Context) -> IL_Result #foreign tobii;

/// Updates the system and receives event callbacks that are called on the calling thread.
///
/// @param  ctx  Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return          IL_Result_Warning_NoAdapterSet if no adapter is set (see IL_CreateInteractionLib() and IL_SetAdapter()); otherwise another IL_Result code.
IL_Update :: (ctx: *IL_Context) -> IL_Result #foreign tobii;

/// Waits for data from the current device.
///
/// May timeout or hang indefinitely depending on adapter implementation. Waiting is optional but if you do not wait,
/// remember to call Update() or UpdateStreamingDataOutput() at least 10 times per second.
///
/// @param  ctx                         Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return IL_Result_Warning_NoAdapterSet  if no adapter is set (see IL_CreateInteractionLib() and IL_SetAdapter()); otherwise another IL_Result code.
IL_WaitForDeviceDataAvailable :: (ctx: *IL_Context) -> IL_Result #foreign tobii;

/// Updates stream buffers and process filters only, and publishes results on the calling thread via the registered streaming data callbacks.
///
/// Use *instead of* IL_Update() if you need more granular control or use multiple threads.
///
/// @param  ctx                       Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return IL_Result_Error_NoAdapterSet  if no adapter is set (see IL_CreateInteractionLib() and IL_SetAdapter()); otherwise another IL_Result code.
IL_UpdateStreamingDataOutput :: (ctx: *IL_Context) -> IL_Result #foreign tobii;

/// Updates interaction buffers, performs interactor selection calculations, and publishes results on calling thread via the registered interaction event callbacks.
///
/// Use *instead of* IL_Update() if you need more granular control or use multiple threads.
///
/// @note                                 IL_UpdateStreamingDataOutput() needs to be called before this call.
/// @param  ctx                       Pointer to an IL_Context structure used internally to identify an actual underlying Interaction Library implementation.
/// @return IL_Result_Error_NoAdapterSet  if no adapter is set (see IL_CreateInteractionLib() and IL_SetAdapter()); otherwise another IL_Result code.
IL_UpdateInteraction :: (ctx: *IL_Context) -> IL_Result #foreign tobii;
