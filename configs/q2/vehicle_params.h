/* Vehicle attitude and rate params */
#define PID_ROLL_RATE_KP  50.0
#define PID_ROLL_RATE_KI  5.0
#define PID_ROLL_RATE_KD  0.0
#define PID_ROLL_RATE_INTEGRATION_LIMIT    33.3

#define PID_PITCH_RATE_KP  50.0
#define PID_PITCH_RATE_KI  5.0
#define PID_PITCH_RATE_KD  0.0
#define PID_PITCH_RATE_INTEGRATION_LIMIT   33.3

#define PID_YAW_RATE_KP  50.0
#define PID_YAW_RATE_KI  5.0
#define PID_YAW_RATE_KD  0.0
#define PID_YAW_RATE_INTEGRATION_LIMIT     166.7

#define PID_ROLL_KP  5.0
#define PID_ROLL_KI  1.0
#define PID_ROLL_KD  0.0
#define PID_ROLL_INTEGRATION_LIMIT    20.0

#define PID_PITCH_KP  5.0
#define PID_PITCH_KI  1.0
#define PID_PITCH_KD  0.0
#define PID_PITCH_INTEGRATION_LIMIT   20.0

#define PID_YAW_KP  18.0
#define PID_YAW_KI  0.0
#define PID_YAW_KD  0.0
#define PID_YAW_INTEGRATION_LIMIT     360.0


#define DEFAULT_PID_INTEGRATION_LIMIT  5000.0

/* Vehicle path following params */
#define PID_X_KP  10.0
#define PID_X_KI  0.05
#define PID_X_KD  5.0

#define PID_Y_KP  10.0
#define PID_Y_KI  0.05
#define PID_Y_KD  5.0

#define PID_Z_KP  3000.0
#define PID_Z_KI  10.0
#define PID_Z_KD  1000.0

#define THRUST_BASE 23000
#define MAX_ROLL_PITCH_ANGLE 10
