// Math constants {{{
#define DEG_TO_RAD (PI/180.0f)
#define RAD_TO_DEG (180.0f/PI)
#define GRAVITY_MAGNITUDE (9.81f) // we use the magnitude such that the sign/direction is explicit in calculations
// }}}

// Vehicle attitude and rate params {{{
#define PID_ROLL_RATE_KP  140.0
#define PID_ROLL_RATE_KI  0.0
#define PID_ROLL_RATE_KD  0.0
#define PID_ROLL_RATE_INTEGRATION_LIMIT    33.3

#define PID_PITCH_RATE_KP  140.0
#define PID_PITCH_RATE_KI  0.0
#define PID_PITCH_RATE_KD  0.0
#define PID_PITCH_RATE_INTEGRATION_LIMIT   33.3

#define PID_YAW_RATE_KP  140.0
#define PID_YAW_RATE_KI  16.7
#define PID_YAW_RATE_KD  0.0
#define PID_YAW_RATE_INTEGRATION_LIMIT     166.7

#define PID_ROLL_KP  6.0
#define PID_ROLL_KI  3.0
#define PID_ROLL_KD  0.0
#define PID_ROLL_INTEGRATION_LIMIT    20.0

#define PID_PITCH_KP  6.0
#define PID_PITCH_KI  3.0
#define PID_PITCH_KD  0.0
#define PID_PITCH_INTEGRATION_LIMIT   20.0

#define PID_YAW_KP  6.0
#define PID_YAW_KI  1.0
#define PID_YAW_KD  0.35
#define PID_YAW_INTEGRATION_LIMIT     360.0


#define DEFAULT_PID_INTEGRATION_LIMIT  5000.0
// }}}

// Vehicle path following params {{{
#define PID_X_KP  10.0
#define PID_X_KI  0.05
#define PID_X_KD  5.0

#define PID_Y_KP  10.0
#define PID_Y_KI  0.05
#define PID_Y_KD  5.0

#define PID_Z_KP  30000.0
#define PID_Z_KI  100.0
#define PID_Z_KD  10000.0

#define THRUST_BASE 50000
#define MAX_ROLL_PITCH_ANGLE 10
// }}}

// EKF Config and Params {{{
#define CONTROL_TO_ACC (GRAVITY_MAGNITUDE/THRUST_BASE)

#define PREDICT_RATE RATE_100_HZ // this is slower than the IMU update rate of 500Hz
#define BARO_RATE RATE_25_HZ

// the point at which the dynamics change from stationary to flying
#define IN_FLIGHT_THRUST_THRESHOLD (GRAVITY_MAGNITUDE*0.1f)
#define IN_FLIGHT_TIME_THRESHOLD (500)

// the reversion of pitch and roll to zero
#define ROLLPITCH_ZERO_REVERSION (1e-3f)

// The bounds on the covariance, these shouldn't be hit, but sometimes are... why?
#define MAX_COVARIANCE (100)
#define MIN_COVARIANCE (1e-6)

// The bounds on states, these shouldn't be hit...
#define MAX_POSITION (10) //meters
#define MAX_VELOCITY (10) //meters per second

// VICON std deviation
#define EXT_MEAS_STD_DEV 0.001

// UWB params
#define METERS_PER_TDOATICK (4.691763979e-3f)
#define SECONDS_PER_TDOATICK (15.650040064e-12f)
// }}}

// vim:foldmethod=marker:foldlevel=0
