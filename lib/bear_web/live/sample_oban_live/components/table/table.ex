defmodule Bear.Live.SampleOban.Components.Table do
  use Phoenix.LiveComponent


  def render(assigns) do
    assigns
    |> assign_new(:header, fn -> [] end)
    |> assign_new(:body, fn -> [] end)
    |> table()
  end

  def table(assigns) do
    ~L"""
    <div class="overflow-x-auto">
      <div class="min-w-screen min-h-screen bg-gray-100 flex justify-center bg-gray-100 font-sans overflow-hidden">
          <div class="w-full lg:w-5/6">
              <div class="bg-white shadow-md rounded my-6">
                  <table class="min-w-max w-full table-auto">
                      <thead>
                          <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                            <%= for thead <- @header do %>
                              <th class="py-3 px-6 text-left"><%= thead.value %></th>
                            <% end %>
                          </tr>
                      </thead>
                      <tbody class="text-gray-600 text-sm font-light">
                        <%= for tbody <- @body do %>
                          <tr class="border-b border-gray-200 hover:bg-gray-100">
                            <%= for thead <- @header do %>
                              <td class="py-3 px-6 text-left whitespace-nowrap">
                                <div class="">
                                <%= if thead.key == :status and tbody[thead.key] == "waiting_to_processing" do %>
                                  <div class="text-xs inline-flex items-center font-bold leading-sm uppercase px-3 py-1 bg-blue-200 text-blue-700 rounded-full">
                                    <svg
                                      xmlns="http://www.w3.org/2000/svg"
                                      width="16"
                                      height="16"
                                      viewBox="0 0 24 24"
                                      fill="none"
                                      stroke="currentColor"
                                      stroke-width="2"
                                      stroke-linecap="round"
                                      stroke-linejoin="round"
                                      class="feather feather-bell-off mr-2"
                                    >
                                      <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                                      <path d="M18.63 13A17.89 17.89 0 0 1 18 8"></path>
                                      <path d="M6.26 6.26A5.86 5.86 0 0 0 6 8c0 7-3 9-3 9h14"></path>
                                      <path d="M18 8a6 6 0 0 0-9.33-5"></path>
                                      <line x1="1" y1="1" x2="23" y2="23"></line>
                                    </svg>
                                    <%= display_option_key(%{key: thead.key, value: tbody[thead.key]}) %>
                                  </div>
                                <%= end %>

                                <%= if thead.key == :status and tbody[thead.key] == "successfully_processed" do %>
                                  <div class="ml-4 text-xs inline-flex items-center font-bold leading-sm uppercase px-3 py-1 bg-green-200 text-green-700 rounded-full">
                                    <svg
                                      xmlns="http://www.w3.org/2000/svg"
                                      width="16"
                                      height="16"
                                      viewBox="0 0 24 24"
                                      fill="none"
                                      stroke="currentColor"
                                      stroke-width="2"
                                      stroke-linecap="round"
                                      stroke-linejoin="round"
                                      class="feather feather-arrow-right mr-2"
                                    >
                                      <line x1="5" y1="12" x2="19" y2="12"></line>
                                      <polyline points="12 5 19 12 12 19"></polyline>
                                    </svg>
                                    <%= display_option_key(%{key: thead.key, value: tbody[thead.key]}) %>
                                  </div>
                                <%= end %>
                                <%= if thead.key == :status and tbody[thead.key] == "processing" do %>
                                  <div class="ml-4 text-xs inline-flex items-center font-bold leading-sm uppercase px-3 py-1 bg-orange-200 text-orange-700 rounded-full">
                                    <svg role="status" class="inline mr-2 w-4 h-4 text-gray-200 animate-spin dark:text-gray-600" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/>
                                    <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="#C05620"/>
                                  </svg>
                                    <%= display_option_key(%{key: thead.key, value: tbody[thead.key]}) %>
                                  </div>
                                <%= end %>
                                <%= if thead.key == :status and tbody[thead.key] == "processed_with_error" do %>
                                  <div class="ml-4 text-xs inline-flex items-center font-bold leading-sm uppercase px-3 py-1 bg-red-200 text-red-700 rounded-full">
                                    <svg
                                      xmlns="http://www.w3.org/2000/svg"
                                      width="16"
                                      height="16"
                                      viewBox="0 0 24 24"
                                      fill="none"
                                      stroke="currentColor"
                                      stroke-width="2"
                                      stroke-linecap="round"
                                      stroke-linejoin="round"
                                      class="feather feather-archive mr-2"
                                    >
                                      <polyline points="21 8 21 21 3 21 3 8"></polyline>
                                      <rect x="1" y="3" width="22" height="5"></rect>
                                      <line x1="10" y1="12" x2="14" y2="12"></line>
                                    </svg>
                                    <%= display_option_key(%{key: thead.key, value: tbody[thead.key]}) %>
                                  </div>
                                <%= end %>
                                <%= if thead.key != :status do %>
                                  <span class="font-medium"><%= tbody[thead.key] || "-" %></span>

                                <%= end %>
                                </div>
                              </td>
                            <% end %>
                          </tr>
                        <% end %>
                      </tbody>
                  </table>
              </div>
          </div>
      </div>
    </div>
    """
  end

  def display_option_key(%{key: nil, value: _}), do: "-"

  def display_option_key(%{key: key, value: value}), do: value


  def display_option_loading(assigns) do
    ~H"""
    <button disabled type="button" class="py-2.5 px-5 mr-2 text-sm font-medium text-gray-900 bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-2 focus:ring-blue-700 focus:text-blue-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700 inline-flex items-center">
      <svg role="status" class="inline mr-2 w-4 h-4 text-gray-200 animate-spin dark:text-gray-600" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/>
        <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="#1C64F2"/>
      </svg>
        Job Generate tax step
    </button>
    """
  end

  def display_option_finished(assigns) do
    ~H"""
    <button disabled type="button" class="py-2.5 px-5 mr-2 text-sm font-medium text-gray-900 bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-2 focus:ring-blue-700 focus:text-blue-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700 inline-flex items-center">
      <svg xmlns="http://www.w3.org/2000/svg" style="height:24px;color:green;margin-right:10px" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
      </svg>
      Job Generate tax, successfully completed
    </button>
    """
  end

  def display_option_failure(assigns) do
    ~H"""
    <button disabled type="button" class="py-2.5 px-5 mr-2 text-sm font-medium text-gray-900 bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-2 focus:ring-blue-700 focus:text-blue-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700 inline-flex items-center">
      <svg xmlns="http://www.w3.org/2000/svg" style="height:24px;color:red;margin-right:10px" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
      </svg>
      Job Generate Tax Failed
    </button>
    """
  end
end
