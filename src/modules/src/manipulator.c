/**
 *    ||          ____  _ __
 * +------+      / __ )(_) /_______________ _____  ___
 * | 0xBC |     / __  / / __/ ___/ ___/ __ `/_  / / _ \
 * +------+    / /_/ / / /_/ /__/ /  / /_/ / / /_/  __/
 *  ||  ||    /_____/_/\__/\___/_/   \__,_/ /___/\___/
 *
 * Crazyflie Firmware
 *
 * Copyright (C) 2016 Bitcraze AB
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, in version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * 
 */
#include <math.h>

#include "FreeRTOS.h"
#include "task.h"

#include "system.h"
#include "log.h"
#include "param.h"

#include "manipulator.h"

#include "string.h"
#include "uart1.h"

static bool isInit;

static void manipulatorTask(void* param);

void manipulatorInit(void)
{
  if(isInit)
    return;

  xTaskCreate(manipulatorTask, MANIPULATOR_TASK_NAME,
              MANIPULATOR_TASK_STACKSIZE, NULL, MANIPULATOR_TASK_PRI, NULL);

  isInit = true;
}

static void manipulatorTask(void* param)
{
  uint32_t tick = 0;
  uint32_t lastWakeTime;
  char text[] = "HELP";
  uint8_t m[32];
  memcpy(m, text, sizeof(&m));
  uart1Init(9600);
  vTaskSetApplicationTaskTag(0, (void*)TASK_MANIPULATOR_ID_NBR);

  //Wait for the system to be fully started to start manipulation loop
  systemWaitStart();

  // Wait for sensors to be calibrated
  lastWakeTime = xTaskGetTickCount ();


  while(1) {
    vTaskDelayUntil(&lastWakeTime, F2T(RATE_MANIPULATOR_LOOP));


    tick++;
    uart1SendData(sizeof(&m), m);
  }
}



