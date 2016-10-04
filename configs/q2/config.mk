## Copy this file to config.mk and modify to get you personal build configuration

## Vehicle type (Crazyflie or Q2)
VEH_FLAGS += -DVEH_Q2

## Enable BigQuad Deck
VEH_FLAGS += -DENABLE_BQ_DECK

## Enable extended kalman filter
# ESTIMATOR = kalman

## Enable UWB sensors
# SENSORS = task
