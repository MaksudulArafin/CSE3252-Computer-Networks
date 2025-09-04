import java.io.*;
import java.net.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class Server {
    public static void main(String[] args) {
        try {
            ServerSocket serverSocket = new ServerSocket(5000);
            System.out.println("Server started. Waiting for client...");

            Socket socket = serverSocket.accept();
            System.out.println("Client connected!");

            // Streams
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            Scanner scanner = new Scanner(System.in);

            // Thread to read messages from client
            Thread readThread = new Thread(() -> {
                String msg;
                try {
                    while ((msg = in.readLine()) != null) {
                        if (msg.equalsIgnoreCase("exit")) {
                            System.out.println("Client left the chat. Goodbye!");
                            socket.close();
                            serverSocket.close();
                            
                            System.exit(0);
                            break;
                        }
                        else if (msg.equalsIgnoreCase("Hi")) {
                            out.println("Hello");
                        } else if (msg.equalsIgnoreCase("Date")) {
                            String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
                            out.println("Server Date: " + date);
                        } else if (msg.equalsIgnoreCase("Time")) {
                            String time = new SimpleDateFormat("HH:mm:ss").format(new Date());
                            out.println("Server Time: " + time);
                        } else if (msg.equalsIgnoreCase("IP")) {
                            out.println("Server IP: " + InetAddress.getLocalHost().getHostAddress());
                        } 
                        System.out.println("Client: " + msg);
                    }
                } catch (IOException e) {
                    System.out.println("Connection closed.");
                }
            });
            readThread.start();

            // Main thread for sending messages
            String message;
            while (true) {
                message = scanner.nextLine();
                out.println(message);
                if (message.equalsIgnoreCase("exit")) {
                    System.out.println("You left the chat.");
                    break;
                }
            }

            scanner.close();            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
