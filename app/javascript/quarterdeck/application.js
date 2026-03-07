import { Application } from "@hotwired/stimulus"
import ChartController from "quarterdeck/controllers/chart_controller"
import DateRangeController from "quarterdeck/controllers/date_range_controller"
import LiveController from "quarterdeck/controllers/live_controller"

const application = Application.start()
application.register("chart", ChartController)
application.register("date-range", DateRangeController)
application.register("live", LiveController)
