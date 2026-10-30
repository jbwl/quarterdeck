import { Application } from "@hotwired/stimulus"
import ChartController from "quarterdeck-csszero/controllers/chart_controller"
import LiveController from "quarterdeck-csszero/controllers/live_controller"
import MenuController from "quarterdeck-csszero/controllers/menu_controller"

const application = Application.start()
application.register("chart", ChartController)
application.register("live", LiveController)
application.register("menu", MenuController)
