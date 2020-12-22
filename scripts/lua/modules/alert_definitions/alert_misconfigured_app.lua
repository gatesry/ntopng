--
-- (C) 2019-20 - ntop.org
--

-- ##############################################

local alert_keys = require "alert_keys"

-- Import the classes library.
local classes = require "classes"
-- Make sure to import the Superclass!
local alert = require "alert"

-- ##############################################

local alert_misconfigured_app = classes.class(alert)

-- ##############################################

alert_misconfigured_app.meta = {
  alert_key = alert_keys.ntopng.alert_misconfigured_app,
  i18n_title = "alerts_dashboard.misconfigured_app",
  icon = "fas fa-cog",
}

-- ##############################################

-- @brief Prepare an alert table used to generate the alert
-- @param one_param The first alert param
-- @param another_param The second alert param
-- @return A table with the alert built
function alert_misconfigured_app:init()
   -- Call the paren constructor
   self.super:init()

   self.alert_type_params = {}
end

-- #######################################################

-- @brief Format an alert into a human-readable string
-- @param ifid The integer interface id of the generated alert
-- @param alert The alert description table, including alert data such as the generating entity, timestamp, granularity, type
-- @param alert_type_params Table `alert_type_params` as built in the `:init` method
-- @return A human-readable string
function alert_misconfigured_app.format(ifid, alert, alert_type_params)
  local alert_severities = require "alert_severities"
  local alert_consts = require("alert_consts")
  local entity = alert_consts.formatAlertEntity(ifid, alert_consts.alertEntityRaw(alert["alert_entity"]), alert["alert_entity_val"])

  if alert.alert_subtype == "too_many_flows" then
    return(i18n("alert_messages.too_many_flows", {iface=entity, option="--max-num-flows/-X"}))
  elseif alert.alert_subtype == "too_many_hosts" then
    return(i18n("alert_messages.too_many_hosts", {iface=entity, option="--max-num-hosts/-x"}))
  else
    return("Unknown app misconfiguration: " .. (alert.alert_subtype or ""))
  end
end

-- #######################################################

return alert_misconfigured_app
