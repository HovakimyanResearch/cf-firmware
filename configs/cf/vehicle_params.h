/* Vehicle attitude and rate params */
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

/* Vehicle path following params */
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
